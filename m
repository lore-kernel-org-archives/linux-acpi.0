From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: [PATCH v3 0/4] Fix Win8 backlight issue
Date: Thu, 26 Sep 2013 09:49:03 +0200
Message-ID: <CADDKRnA7Eqox6s6t315c=OaEpAgRcX62_4rF8XuXaNRAipOqcQ@mail.gmail.com>
References: <1380016052-15315-1-git-send-email-aaron.lu@intel.com>
	<1380026575.3371.1.camel@ThinkPad-X230.localdomain>
	<CADDKRnCAZ0DtBUUaMfdTF=yk6PDLpbc9jkuvWWO8hYW4TDLxKw@mail.gmail.com>
	<20130925091720.GA1921@aaronlu.sh.intel.com>
	<87vc1p4207.fsf@intel.com>
	<CADDKRnDqDBfA6e6TE0VTLD9F=TjVZNov53Zk8ydnk2fS32rczQ@mail.gmail.com>
	<87eh8clvun.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <87eh8clvun.fsf@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: James Hogan <james@albanarts.com>, Martin Steigerwald <Martin@lichtvoll.de>, Felipe Contreras <felipe.contreras@gmail.com>, dri-devel@lists.freedesktop.org, Matthew Garrett <matthew.garrett@nebula.com>, Mike Galbraith <bitbucket@online.de>, Kalle Valo <kvalo@adurom.com>, Yves-Alexis Perez <corsac@debian.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lee Chun-Yi <joeyli.kernel@gmail.com>, Ben Jencks <ben@bjencks.net>, intel-gfx <intel-gfx@lists.freedesktop.org>, Joerg Platte <jplatte@naasa.net>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, "Rafael J. Wysocki" <rjw@sisk.pl>, Seth Forshee <seth.forshee@canonical.com>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Aaron Lu <aaron.lu@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-acpi@vger.kernel.org

MjAxMy85LzI1IEphbmkgTmlrdWxhIDxqYW5pLm5pa3VsYUBsaW51eC5pbnRlbC5jb20+Ogo+IE9u
IFdlZCwgMjUgU2VwIDIwMTMsIErDtnJnIE90dGUgPGpyZy5vdHRlQGdtYWlsLmNvbT4gd3JvdGU6
Cj4+IDIwMTMvOS8yNSBKYW5pIE5pa3VsYSA8amFuaS5uaWt1bGFAbGludXguaW50ZWwuY29tPjoK
Pj4+IE9uIFdlZCwgMjUgU2VwIDIwMTMsIEFhcm9uIEx1IDxhYXJvbi5sdUBpbnRlbC5jb20+IHdy
b3RlOgo+Pj4+IE9uIFdlZCwgU2VwIDI1LCAyMDEzIGF0IDEwOjI5OjM3QU0gKzAyMDAsIErDtnJn
IE90dGUgd3JvdGU6Cj4+Pj4+IEJhY2tsaWdodCBjYW4ndCBiZSBtb2RpZmllZCB3aXRoIHRoaXMg
cGF0Y2ggc2V0IC0gbmVpdGhlciB3aXRoCj4+Pj4+IGZ1bmN0aW9uIGtleXMgbm9yIHdpdGggdGhl
IGd1aS4gSXQgaXMgYSBzdGVwIGJhY2t3YXJkIHRvIHYzLjExLXJjMQo+Pj4KPj4+IFNvIGJvdGgg
aG90a2V5cyBhbmQgR1VJIHdvcmsgaW4gdjMuMTEtcmMxPyBBbmQgdjMuMTItcmMyPwo+Pgo+PiBJ
biAgdjMuMTEtcmMxIGl0IGRpZG4ndCB3b3JrLgo+PiBTaW5jZSBhIGxhdGVyIHJjIChJIGRvbid0
IHJlbWVtYmVyIGV4YWN0bHkgd2hpY2gpIGl0IGRpZCB3b3JrLgo+PiBJbiB2My4xMi1yYzEvMiBp
dCBkb2VzIHdvcmsuCj4+IEluIHYzLjEyLXJjMiArIEFhcm9uJ3MgcGF0Y2ggc2V0IGl0IGFnYWlu
IGRvZXNuJ3Qgd29yay4KPj4KPj4+Cj4+Pj4gVGhhbmtzIGZvciB0aGUgdGVzdC4KPj4+Pgo+Pj4+
IFBsZWFzZSBjaGVjayAvc3lzL2NsYXNzL2JhY2tsaWdodCwgaXMgdGhlcmUgb25seSBvbmUgbGlu
ayBmaWxlCj4+Pj4gaW50ZWxfYmFja2xpZ2h0Pwo+Pj4KPj4+IEluZGVlZCwgYXJlIHRoZXJlIG90
aGVycz8gZnVqaXRzdS1sYXB0b3AgcGVyaGFwcz8gSWYgeWVzLCB0cnkKPj4+IENPTkZJR19GVUpJ
VFNVX0xBUFRPUD1uIG9yIGFuIGFwcHJvcHJpYXRlIG1vZHVsZSBibGFja2xpc3QuCj4+Pgo+Pj4g
SnVzdCBjaGVja2luZywgeW91IGRvIGhhdmUgQ09ORklHX0JBQ0tMSUdIVF9DTEFTU19ERVZJQ0U9
eT8KPj4KPj4gVGhlcmUgaXMgb25seSBvbmUgaW50ZWxfYmFja2xpZ2h0IGxpbmsuCj4+IFllcywg
SSBoYXZlIENPTkZJR19CQUNLTElHSFRfQ0xBU1NfREVWSUNFPXkKPj4KPj4+IEVtYmFycmFzc2lu
Z2x5IHRoZXJlIHdhcyBhIGJ1ZyBpbiBpOTE1IGZpeGVkIGp1c3QgcmVjZW50bHkgd2hlcmUgdGhl
Cj4+PiBiYWNrbGlnaHQgZGV2aWNlIHdhc24ndCByZWdpc3RlcmVkIGZvcgo+Pj4gQ09ORklHX0JB
Q0tMSUdIVF9DTEFTU19ERVZJQ0U9bS4uLgo+Pj4KPj4+PiBJZiBzbywgcGxlYXNlIGNkIGluc2lk
ZSBhbmQgdHJ5IG1vZGlmeSB0aGUgYnJpZ2h0bmVzcyBmaWxlIHVzaW5nIGVjaG8KPj4+PiB3aXRo
IHNvbWUgdmFsdWVzIGluIHRoZSByYW5nZSBvZiAwIC0gbWF4X2JyaWdodG5lc3MsIGRvZXMgdGhl
Cj4+Pj4gYmFja2xpZ2h0IGxldmVsIGNoYW5nZSB3aGVuIHlvdSBlY2hvIGEgbmV3IHZhbHVlPyBJ
IGd1ZXNzIGl0IGRvZXNuJ3QsCj4+Pj4gb3IgeW91IHdvdWxkbid0IG5vdGljZSBwcm9ibGVtLiBJ
ZiBpbmRlZWQgc28sIHBlcmhhcHMgZmlsZSBhIGJ1ZyBhdAo+Pj4+IGh0dHA6Ly9idWd6aWxsYS5r
ZXJuZWwub3JnLCBEcml2ZXJzL1ZpZGVvKERSSS1JbnRlbCk/IEkgc3VwcG9zZSBKYW5pCj4+Pj4g
YW5kIERhbmllbCBjYW4gaGVscCBmaXggeW91ciBwcm9ibGVtLgo+Pj4KPj4+IFl1cCwgcGxlYXNl
IGNoZWNrIHRoZSBhYm92ZSwgYW5kIHJlcG9ydCBiYWNrLgo+Pgo+PiAtIGVjaG8gMC4ubWF4X2Jy
aWdodG5lc3MgPiBicmlnaHRuZXNzIGRvZXMgbm90IHdvcmsuCj4KPiBUaGFua3MgZm9yIHRoZSBp
bmZvLgo+Cj4gSG93IGFib3V0IHYzLjEyLXJjMiB3aXRob3V0IEFhcm9uJ3MgcGF0Y2hlcz8gRG9l
cyBpbnRlbF9iYWNrbGlnaHQgYWxzbwo+IG5vdCB3b3JrIHRoZXJlPyBIb3cgYWJvdXQgdGhlIGFj
cGlfdmlkZW8wICh3aGljaCBJIHByZXN1bWUgaXMgcHJlc2VudCkKPiBzeXNmcyBpbnRlcmZhY2U/
Cj4KCldpdGhvdXQgQWFyb24ncyBwYXRjaGVzIGludGVsX2JhY2tsaWdodCBhbHNvIGRvZXMgbm90
IHdvcmsuCkJ1dCBhY3BpX3ZpZGVvMCBkb2VzIChhbmQgdGFrZXMgcHJlY2VkZW5jZSBJIHRoaW5r
KS4KCj4+Pj4+IFZpZGVvIGRyaXZlcjogaTkxNQo+Pj4+PiBGVUpJVFNVIExJRkVCT09LIEFINTMy
L0ZKTkJCMUMsIEJJT1MgVmVyc2lvbiAxLjA5IDA1LzIyLzIwMTIKPj4KPj4gSsO2cmcKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxp
bmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK
