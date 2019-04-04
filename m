From: Adam Borowski <kilobyte-b9QjgO8OEXPVItvQsEIGlw@public.gmane.org>
Subject: Re: [PATCH v4 5/5] xfs: disable map_sync for async flush
Date: Thu, 4 Apr 2019 11:56:49 +0200
Message-ID: <20190404095649.GB8738@angband.pl>
References: <20190403104018.23947-1-pagupta@redhat.com>
 <20190403104018.23947-6-pagupta@redhat.com>
 <20190403220912.GB26298@dastard>
 <1518295599.17367903.1554358350929.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1518295599.17367903.1554358350929.JavaMail.zimbra-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Pankaj Gupta <pagupta-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: cohuck-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jack-AlSwsSmVLrQ@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Dave Chinner <david-FqsqvQoI3Ljby3iVrkZq2A@public.gmane.org>, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, adilger kernel <adilger.kernel-m1MBpc4rdrD3fQ9qLvQP4Q@public.gmane.org>, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, david-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ext4-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org, stefanha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lcapitulino-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kwolf-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, nilal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tytso-3s7WtUTddSA@public.gmane.org, xiaoguangrong eric <xiaoguangrong.eric-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, darrick wong <darrick.wong-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, imammedo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

T24gVGh1LCBBcHIgMDQsIDIwMTkgYXQgMDI6MTI6MzBBTSAtMDQwMCwgUGFua2FqIEd1cHRhIHdy
b3RlOgo+ID4gQWxsIHRoaXMgYWQgaG9jIElTX0RBWCBjb25kaXRpb25hbCBsb2dpYyBpcyBnZXR0
aW5nIHByZXR0eSBuYXN0eS4KPiA+IAo+ID4geGZzX2ZpbGVfbW1hcCgKPiA+IC4uLi4KPiA+IHsK
PiA+IAlzdHJ1Y3QgaW5vZGUJKmlub2RlID0gZmlsZV9pbm9kZShmaWxwKTsKPiA+IAo+ID4gCWlm
ICh2bWEtPnZtX2ZsYWdzICYgVk1fU1lOQykgewo+ID4gCQlpZiAoIUlTX0RBWChpbm9kZSkpCj4g
PiAJCQlyZXR1cm4gLUVPUE5PVFNVUFA7Cj4gPiAJCWlmICghZGF4X3N5bmNocm9ub3VzKHhmc19m
aW5kX2RheGRldl9mb3JfaW5vZGUoaW5vZGUpKQo+ID4gCQkJcmV0dXJuIC1FT1BOT1RTVVBQOwo+
ID4gCX0KPiA+IAo+ID4gCWZpbGVfYWNjZXNzZWQoZmlscCk7Cj4gPiAJdm1hLT52bV9vcHMgPSAm
eGZzX2ZpbGVfdm1fb3BzOwo+ID4gCWlmIChJU19EQVgoaW5vZGUpKQo+ID4gCQl2bWEtPnZtX2Zs
YWdzIHw9IFZNX0hVR0VQQUdFOwo+ID4gCXJldHVybiAwOwo+ID4gfQo+IAo+IFN1cmUsIHRoaXMg
aXMgYmV0dGVyLgoKPiA+IEV2ZW4gYmV0dGVyLCBmYWN0b3Igb3V0IGFsbCB0aGUgIk1BUF9TWU5D
IHN1cHBvcnRlZCIgY2hlY2tzIGludG8gYQo+ID4gaGVscGVyIHNvIHRoYXQgdGhlIGZpbGVzeXN0
ZW0gY29kZSBqdXN0IGRvZXNuJ3QgaGF2ZSB0byBjYXJlIGFib3V0Cj4gPiB0aGUgZGV0YWlscyBv
ZiBjaGVja2luZyBmb3IgREFYK01BUF9TWU5DIHN1cHBvcnQuLi4uCj4gCj4gby5rLiBXaWxsIGFk
ZCBvbmUgY29tbW9uIGhlbHBlciBmdW5jdGlvbiBmb3IgYm90aCBleHQ0ICYgeGZzIGZpbGVzeXN0
ZW1zLgoKTm90ZSB0aGlzIHBlbmRpbmcgcGF0Y2ggZm9yIEdvbGR3eW4gUm9kcmlndWVzJyBwYXRj
aHNldCBmb3IgYnRyZnM6CgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1idHJmcy8yMDE5
MDMyODEwMjQxOC41NDY2LTEta2lsb2J5dGVAYW5nYmFuZC5wbC8KCldlIG1pZ2h0IHdhbnQgdG8g
Y29vcmRpbmF0ZS4KCgpNZW93IQotLSAK4qKA4qO04qC+4qC74qK24qOm4qCACuKjvuKggeKioOKg
kuKggOKjv+KhgSBEaWQgeWEga25vdyB0aGF0IHR5cGluZyAidGVzdCAtajgiIGluc3RlYWQgb2Yg
ImN0ZXN0IC1qOCIK4qK/4qGE4qCY4qC34qCa4qCL4qCAIHdpbGwgbWFrZSB5b3VyIHRlc3RzdWl0
ZSBwYXNzIG11Y2ggZmFzdGVyLCBhbmQgZml4IGJ1Z3M/CuKgiOKgs+KjhOKggOKggOKggOKggApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRp
bW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0cy4w
MS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
