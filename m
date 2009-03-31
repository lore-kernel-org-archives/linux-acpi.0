From: Tony Vroon <tony@linx.net>
Subject: Re: [PATCH 06/10] fujitsu-laptop: use .notify method instead of
 installing handler directly
Date: Tue, 31 Mar 2009 23:09:13 +0100
Message-ID: <20090331230913.18c9e039@linx.net>
References: <20090330174646.20905.18465.stgit@bob.kio>
	<20090330174839.20905.63966.stgit@bob.kio>
	<20090331223805.5356a323@linx.net>
	<200903311609.12829.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:49255 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757901AbZCaWL7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Mar 2009 18:11:59 -0400
In-Reply-To: <200903311609.12829.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMQ0KDQpPbiBUdWUs
IDMxIE1hciAyMDA5IDE2OjA5OjExIC0wNjAwDQpCam9ybiBIZWxnYWFzIDxiam9ybi5oZWxnYWFz
QGhwLmNvbT4gd3JvdGU6DQo+IElmIHlvdSBkb24ndCBvYmplY3QsIEknbGwgYWxzbyBhZGQgYSAi
VGVzdGVkLUJ5OiBUb255IFZyb29uIDx0b255QGxpbngubmV0PiIgYW5kIHRoZSBjb25maWcgdG8g
dGhlc2UNCj4gdHdvIHBhdGNoZXMuDQoNCkdvIGZvciBpdC4NCg0KPiBCam9ybg0KDQpSZWdhcmRz
LA0KVG9ueSBWLg0KLS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NClZlcnNpb246IEdudVBH
IHYyLjAuMTEgKEdOVS9MaW51eCkNCg0KaUVZRUFSRUNBQVlGQWtuU2xJMEFDZ2tRcDV2VzRyVUZq
NXB0R0FDZ2gyN2Y0dXhMOWJCeHJJQWJYWS9pYXV1eA0KNUxVQW5BOEF4a2pnNnpoNXhjNjVka0JM
QTNBK2xRME8NCj1ZL1RpDQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg==
