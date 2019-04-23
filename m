From: "Robert R. Howell" <RHowell@uwyo.edu>
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
Date: Tue, 23 Apr 2019 20:03:08 +0000
Message-ID: <144b56d4-54e6-bccd-4652-22303bcd9168@uwyo.edu>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
 <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
 <feb1808d-542c-83c2-5c70-9228473bb8d0@redhat.com>
 <0a770539-dfe9-2eb6-a90a-82f065a23a3f@uwyo.edu>
 <f6db39bc-b8d1-fda8-ad37-a8b050ef0027@redhat.com>
 <37aee883-1253-adad-82b4-4a578cc72825@uwyo.edu>
 <CAJZ5v0j9U20cFbRx6QKeQv6wyDg6nL71L0U_Rec5+W1JoD8-=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j9U20cFbRx6QKeQv6wyDg6nL71L0U_Rec5+W1JoD8-=w@mail.gmail.com>
Content-Language: en-US
Content-ID: <E6BD045827275745BB4D9BFBEC234952@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Robert R. Howell" <RHowell@uwyo.edu>
List-Id: linux-acpi@vger.kernel.org

T24gNC8yMy8xOSAyOjA3IEFNLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gDQo+IE9uIFNh
dCwgQXByIDIwLCAyMDE5IGF0IDEyOjQ0IEFNIFJvYmVydCBSLiBIb3dlbGwgPFJIb3dlbGxAdXd5
by5lZHU+IHdyb3RlOg0KPj4NCj4+IE9uIDQvMTgvMTkgNTo0MiBBTSwgSGFucyBkZSBHb2VkZSB3
cm90ZToNCj4+DQo+Pj4+IE9uIDQvOC8xOSAyOjE2IEFNLCBIYW5zIGRlIEdvZWRlIHdyb3RlOj4N
Cj4+Pj4+DQo+Pj4+PiBIbW0sIGludGVyZXN0aW5nIHNvIHlvdSBoYXZlIGhpYmVybmF0aW9uIHdv
cmtpbmcgb24gYSBUMTAwVEENCj4+Pj4+ICh3aXRoIDUuMCArIDAyZTQ1NjQ2ZDUzYiByZXZlcnRl
ZCksIHJpZ2h0ID8NCj4+Pj4+DQo+Pg0KPj4NCj4+IEkndmUgbWFuYWdlZCB0byBmaW5kIGEgd2F5
IGFyb3VuZCB0aGUgaTJjX2Rlc2lnbndhcmUgdGltZW91dCBpc3N1ZXMNCj4+IG9uIHRoZSBUMTAw
VEEncy4gIFRoZSBrZXkgaXMgdG8gTk9UIHNldCBEUE1fRkxBR19TTUFSVF9TVVNQRU5ELA0KPj4g
d2hpY2ggd2FzIGFkZGVkIGluIHRoZSAwMmU0NTY0NmQ1M2IgY29tbWl0Lg0KPj4NCj4+IFRvIHRl
c3QgdGhhdCBJJ3ZlIHN0YXJ0ZWQgd2l0aCBhIDUuMS1yYzUga2VybmVsLCBhcHBsaWVkIHlvdXIg
cmVjZW50IHBhdGNoDQo+PiB0byBhY3BpX2xwc3MuYywgdGhlbiBhcHBseSB0aGUgZm9sbG93aW5n
IHBhdGNoIG9mIG1pbmUsIHJlbW92aW5nDQo+PiBEUE1fRkxBR19TTUFSVF9TVVNQRU5ELiAgKEZv
ciB0aGUgVDEwMCBoYXJkd2FyZSBJIG5lZWQgdG8gYXBwbHkgc29tZQ0KPj4gb3RoZXIgcGF0Y2hl
cyBhcyB3ZWxsIGJ1dCB0aG9zZSBhcmUgbm90IHJlbGF0ZWQgdG8gdGhlIGkyYy1kZXNpZ253YXJl
IG9yDQo+PiBhY3BpIGlzc3VlcyBhZGRyZXNzZWQgaGVyZS4pDQo+Pg0KPj4gT24gYSByZXN1bWUg
ZnJvbSBoaWJlcm5hdGlvbiBJIHN0aWxsIHNlZSBvbmUgZXJyb3I6DQo+PiAgICJpMmNfZGVzaWdu
d2FyZSA4MDg2MEY0MTowMDogRXJyb3IgaTJjX2R3X3hmZXIgY2FsbGVkIHdoaWxlIHN1c3BlbmRl
ZCINCj4+IGJ1dCBJIG5vIGxvbmdlciBnZXQgdGhlIGkyY19kZXNpZ253YXJlIHRpbWVvdXRzLCBh
bmQgYXVkaW8gZG9lcyBub3cgd29yaw0KPj4gYWZ0ZXIgdGhlIHJlc3VtZS4NCj4+DQo+PiBSZW1v
dmluZyBEUE1fRkxBR19TTUFSVF9TVVNQRU5EIG1heSBub3QgYmUgd2hhdCB5b3Ugd2FudCBmb3Ig
b3RoZXINCj4+IGhhcmR3YXJlLCBidXQgcGVyaGFwcyB0aGlzIHdpbGwgZ2l2ZSB5b3UgYSBjbHVl
IGFzIHRvIHdoYXQgaXMgZ29pbmcNCj4+IHdyb25nIHdpdGggaGliZXJuYXRlL3Jlc3VtZSBvbiB0
aGUgVDEwMFRBJ3MuDQo+IA0KPiBXaGF0IGlmIHlvdSBkcm9wIERQTV9GTEFHX0xFQVZFX1NVU1BF
TkRFRCBhbG9uZSBpbnN0ZWFkPw0KPiANCg0KSSBkaWQgdHJ5IGRyb3BwaW5nIGp1c3QgRFBNX0ZM
QUdfTEVBVkVfU1VTUEVOREVELCBkcm9wcGluZyBqdXN0IA0KRFBNX0ZMQUdfU01BUlRfU1VTUEVO
RCwgYW5kIGRyb3BwaW5nIGJvdGggZmxhZ3MuICBXaGVuIEkganVzdCBkcm9wIA0KRFBNX0ZMQUdf
TEVBVkVfU1VTUEVOREVEIEkgc3RpbGwgZ2V0IHRoZSBpMmNfZGVzaWdud2FyZSB0aW1lb3V0cyAN
CmFmdGVyIHRoZSByZXN1bWUuICBJZiBJIGRyb3AganVzdCBEUE1fRkxBR19TTUFSVF9TVVNQRU5E
IG9yIGRyb3AgYm90aCwgDQp0aGVuIHRoZSB0aW1lb3V0cyBnbyBhd2F5Lg0KDQpCb2IgSG93ZWxs
DQo=
