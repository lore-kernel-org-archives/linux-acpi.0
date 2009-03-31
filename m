From: Tony Vroon <tony@linx.net>
Subject: Re: [PATCH 07/10] fujitsu-laptop: use .notify method instead of
 installing hotkey handler directly
Date: Tue, 31 Mar 2009 22:39:52 +0100
Message-ID: <20090331223952.1a84b668@linx.net>
References: <20090330174646.20905.18465.stgit@bob.kio>
	<20090330174844.20905.18635.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:60770 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756698AbZCaVuK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Mar 2009 17:50:10 -0400
In-Reply-To: <20090330174844.20905.18635.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMQ0KDQpPbiBNb24s
IDMwIE1hciAyMDA5IDExOjQ4OjQ0IC0wNjAwDQpCam9ybiBIZWxnYWFzIDxiam9ybi5oZWxnYWFz
QGhwLmNvbT4gd3JvdGU6DQoNCj4gVGhpcyBwYXRjaCBhZGRzIGEgLm5vdGlmeSgpIG1ldGhvZC4g
IFRoZSBwcmVzZW5jZSBvZiAubm90aWZ5KCkgY2F1c2VzDQo+IExpbnV4L0FDUEkgdG8gbWFuYWdl
IGV2ZW50IGhhbmRsZXJzIGFuZCBub3RpZnkgaGFuZGxlcnMgb24gb3VyIGJlaGFsZiwNCj4gc28g
d2UgZG9uJ3QgaGF2ZSB0byBpbnN0YWxsIGFuZCByZW1vdmUgdGhlbSBvdXJzZWx2ZXMuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBCam9ybiBIZWxnYWFzIDxiam9ybi5oZWxnYWFzQGhwLmNvbT4NCj4g
Q0M6IEpvbmF0aGFuIFdvaXRoZSA8andvaXRoZUBwaHlzaWNzLmFkZWxhaWRlLmVkdS5hdT4NCkFj
a2VkLUJ5OiBUb255IFZyb29uIDx0b255QGxpbngubmV0Pg0KDQpBcHBsaWNhdGlvbiBwYW5lbCBi
dXR0b24gZXZlbnRzIGNvbnRpbnVlIHRvIGJlIGRlbGl2ZXJlZCB3aXRoDQp0aGlzIHBhdGNoc2V0
IGFwcGxpZWQgdG8gMi42LjI5OyB0ZXN0IHBsYXRmb3JtIGlzIGEgRnVqaXRzdS1TaWVtZW5zDQpM
aWZlYm9vayBTNjQyMCBbRkpOQjFFNl0gd2l0aCBCSU9TIDEuMTggKDAxLzA5LzIwMDkpLg0KVGhl
IGNvZGUgYWxzbyBnZXRzIG11Y2ggZWFzaWVyIHRvIHJlYWQuIFRoYW5rcyBmb3IgdGhpcyBCam9y
bi4NCg0KUmVnYXJkcywNClRvbnkgVi4NCi0tLS0tQkVHSU4gUEdQIFNJR05BVFVSRS0tLS0tDQpW
ZXJzaW9uOiBHbnVQRyB2Mi4wLjExIChHTlUvTGludXgpDQoNCmlFWUVBUkVDQUFZRkFrblNqYW9B
Q2drUXA1dlc0clVGajVvcWd3Q2dvTExJc3U2Y3NOMmovWFRwWE8zY3MrQXcNCnZ0Z0FuUk1jM0My
a3lMYnp5NVJpZFg3RkxxZXdHVzZNDQo9Qm9NYg0KLS0tLS1FTkQgUEdQIFNJR05BVFVSRS0tLS0t
DQo=
