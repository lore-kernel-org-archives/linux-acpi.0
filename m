From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: [patch 06/12] Link newly created pci child bus to its parent on creation
Date: Fri, 18 Mar 2005 23:01:18 -0500
Message-ID: <200503182301.19496.dtor_core@ameritech.net>
References: <20050318133856.A878@unix-os.sc.intel.com> <20050318140922.F1145@unix-os.sc.intel.com> <200503182300.12924.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: base64
In-Reply-To: <200503182300.12924.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, gregkh-l3A5Bk7waGM@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

T24gRnJpZGF5IDE4IE1hcmNoIDIwMDUgMjM6MDAsIERtaXRyeSBUb3Jva2hvdiB3cm90ZToKPiBI
aSwKPiAKPiBPbiBGcmlkYXkgMTggTWFyY2ggMjAwNSAxNzowOSwgUmFqZXNoIFNoYWggd3JvdGU6
Cj4gPiAroKCgoKCgoKCgoKCgoKCgaWYgKGRldi0+c3Vib3JkaW5hdGUpIHsKPiA+ICugoKCgoKCg
oKCgoKCgoKAgoCCgIKAgaWYgKGxpc3RfZW1wdHkoJmRldi0+c3Vib3JkaW5hdGUtPm5vZGUpKSB7
Cj4gPiAroKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgoCCgIKAgc3Bpbl9sb2NrKCZwY2lfYnVzX2xv
Y2spOwo+ID4gK6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIKAgoCCgIGxpc3RfYWRkX3RhaWwoJmRl
di0+c3Vib3JkaW5hdGUtPm5vZGUsCj4gPiAroKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIKAgoCCgICZkZXYtPmJ1cy0+Y2hpbGRyZW4pOwo+ID4gK6CgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIKAgoCCgIHNwaW5fdW5sb2NrKCZwY2lfYnVzX2xvY2spOwo+ID4gK6CgoKCgoKCg
oKCgoKCgoCCgIKAgoCB9Cj4gCj4gU2hvdWxkJ250IHNwaW5fbG9jay91bmxvY2sgYmUgYXJvdW5k
IGVudGlyZSAiaWYiIHN0YXRlbWVudD8gbGlzdF9lbXB0eQo+IGNvdWxkIGJlY29tZSBmYWxzZSBh
ZnRlciBpdCB3YXMgY2hlY2tsZWQgYnV0IGJlZm9yZSBzcGlubG9jayB3YXMgYWNxdWlyZWQuCgpT
Y3JhdGNoIHRoYXQsIEkgbWlzcmVhZCB0aGUgY29kZSwgc29ycnkuCgotLSAKRG1pdHJ5Cg==


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
