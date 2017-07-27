From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v6 1/1] acpi: apei: Enable APEI multiple GHES source to
 share a single external IRQ
Date: Thu, 27 Jul 2017 16:49:16 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F61317AEB@ORSMSX114.amr.corp.intel.com>
References: <1500661477-6536-1-git-send-email-lho@apm.com>
 <20170722055954.GA2082@nazgul.tnic> <1893763.BLgt1zgLk5@aspire.rjw.lan>
 <1632667.Vgem7HtdXu@aspire.rjw.lan> <20170727055825.GA4611@nazgul.tnic>
 <CAJZ5v0jVSrsufoWyexb_MWS=ni0CDn7Oo1-oHOcaTxdYpfpQMg@mail.gmail.com>
 <20170727144922.GF28553@nazgul.tnic>
 <CAJZ5v0gQ5aYZw8NOpvmw-1zqfFg_k+nkTZxEocnT=hDk37VsGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:37693 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbdG0Qu4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Jul 2017 12:50:56 -0400
In-Reply-To: <CAJZ5v0gQ5aYZw8NOpvmw-1zqfFg_k+nkTZxEocnT=hDk37VsGA@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Loc Ho <lho@apm.com>, Mark Salter <msalter@redhat.com>, Tyler Baicar <tbaicar@codeaurora.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "patches@apm.com" <patches@apm.com>

Pj4gUHJvdmlkZWQgVG9ueSBhZ3JlZXMgdGhvdWdoLi4uIEknZCB2ZW50dXJlIGEgZ3Vlc3MgYW5k
IHNheSB0aGF0IGhlDQo+PiBkb2Vzbid0IGhhdmUgYSBjaG9pY2UsIHdvYWhhaGhhaGFoYS4uLg0K
Pj4NCj4+IDotKSkpDQo+DQo+IFdlbGwsIEkgZ3Vlc3Mgc2VuZCB0aGlzIG9mZmljaWFsbHkgd2l0
aCBhIENDOlRvbnkgYW5kIHNlZSB3aGF0IGhlIHNheXMuIDotKQ0KDQpUaGF0J3MgZGVmaW5pdGVs
eSBwYXJ0IG9mIG15IGRheSBqb2IgLi4uIHNvIHllcywgcGxlYXNlIGFkZCBtZSBhcyBhIHJldmll
d2VyLg0KDQotVG9ueQ0K
