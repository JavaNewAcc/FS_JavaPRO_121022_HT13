package academy.prog;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RestController
public class UrlController {
    private final UrlService urlService;

    public UrlController(UrlService urlService) {
        this.urlService = urlService;
    }

    @GetMapping("shorten_simple")
    public List<UrlResultDTO> shorten(@RequestParam String urls) { // Jackson / GSON
        List<UrlResultDTO> list = new ArrayList<>();

        String[] listUrls = urls.split("&");

        for (String url : listUrls) {

            var urlDTO = new UrlDTO();
            urlDTO.setUrl(url);

            long id = urlService.saveUrl(urlDTO);

            var result = new UrlResultDTO();
            result.setUrl(urlDTO.getUrl());
            result.setShortUrl(Long.toString(id));

            list.add(result);
        }
        return list;
    }

    @PostMapping("shorten")
    public List<UrlResultDTO> shorten(@RequestBody ArrayList<UrlDTO> urlDTO) { // Jackson / GSON

        List<UrlResultDTO> resDTOlist = new ArrayList<>();

        for (UrlDTO oneUrlDTO : urlDTO) {

            long id = urlService.saveUrl(oneUrlDTO);

            var result = new UrlResultDTO();
            result.setUrl(oneUrlDTO.getUrl());
            result.setShortUrl(Long.toString(id));

            resDTOlist.add(result);
        }
        return resDTOlist;
    }

    /*
        302
        Location: https://goto.com
        Cache-Control: no-cache, no-store, must-revalidate
     */

    @GetMapping("my/{id}")
    public ResponseEntity<Void> redirect(@PathVariable("id") Long id) {
        var url = urlService.getUrl(id);

        var headers = new HttpHeaders();
        headers.setLocation(URI.create(url));
        headers.setCacheControl("no-cache, no-store, must-revalidate");

        return new ResponseEntity<>(headers, HttpStatus.FOUND);
    }

    @GetMapping("stat")
    public List<UrlStatDTO> stat() {
        return urlService.getStatistics();
    }
}
