From: Tony Vroon <tony@linx.net>
Subject: Re: [PATCH 06/10] fujitsu-laptop: use .notify method instead of
 installing handler directly
Date: Tue, 31 Mar 2009 22:38:05 +0100
Message-ID: <20090331223805.5356a323@linx.net>
References: <20090330174646.20905.18465.stgit@bob.kio>
	<20090330174839.20905.63966.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:60773 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459AbZCaVuK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Mar 2009 17:50:10 -0400
In-Reply-To: <20090330174839.20905.63966.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMQ0KDQpPbiBNb24s
IDMwIE1hciAyMDA5IDExOjQ4OjM5IC0wNjAwDQpCam9ybiBIZWxnYWFzIDxiam9ybi5oZWxnYWFz
QGhwLmNvbT4gd3JvdGU6DQo+IFRoaXMgcGF0Y2ggYWRkcyBhIC5ub3RpZnkoKSBtZXRob2QuICBU
aGUgcHJlc2VuY2Ugb2YgLm5vdGlmeSgpIGNhdXNlcw0KPiBMaW51eC9BQ1BJIHRvIG1hbmFnZSBl
dmVudCBoYW5kbGVycyBhbmQgbm90aWZ5IGhhbmRsZXJzIG9uIG91ciBiZWhhbGYsDQo+IHNvIHdl
IGRvbid0IGhhdmUgdG8gaW5zdGFsbCBhbmQgcmVtb3ZlIHRoZW0gb3Vyc2VsdmVzLg0KIA0KPiBT
aWduZWQtb2ZmLWJ5OiBCam9ybiBIZWxnYWFzIDxiam9ybi5oZWxnYWFzQGhwLmNvbT4NCj4gQ0M6
IEpvbmF0aGFuIFdvaXRoZSA8andvaXRoZUBwaHlzaWNzLmFkZWxhaWRlLmVkdS5hdT4NCkFja2Vk
LUJ5OiBUb255IFZyb29uIDx0b255QGxpbngubmV0Pg0KDQpEb2NrL2xpZC9yYWRpbyBub3RpZmlj
YXRpb25zIGNvbnRpbnVlIHRvIGJlIGRlbGl2ZXJlZCB3aXRoIHRoaXMNCnBhdGNoc2V0IGFwcGxp
ZWQgdG8gMi42LjI5OyB0ZXN0IHBsYXRmb3JtIGlzIGEgRnVqaXRzdS1TaWVtZW5zIExpZmVib29r
DQpTNjQyMCBbRkpOQjFFNl0gd2l0aCBCSU9TIDEuMTggKDAxLzA5LzIwMDkpLg0KVGhlIGNvZGUg
YWxzbyBnZXRzIG11Y2ggZWFzaWVyIHRvIHJlYWQuIFRoYW5rcyBmb3IgdGhpcyBCam9ybi4NCg0K
UmVnYXJkcywNClRvbnkgVi4NCi0tLS0tQkVHSU4gUEdQIFNJR05BVFVSRS0tLS0tDQpWZXJzaW9u
OiBHbnVQRyB2Mi4wLjExIChHTlUvTGludXgpDQoNCmlFWUVBUkVDQUFZRkFrblNqVUVBQ2drUXA1
dlc0clVGajVyTUxBQ2ZlKzJkM0pjb2w0WDlKOTljQStiRUlMUVoNCmI1MEFtd1RxN0RrYXdmaDRN
eHJoellnQWpUSXJ3VkJ1DQo9NnNXQw0KLS0tLS1FTkQgUEdQIFNJR05BVFVSRS0tLS0tDQo=
