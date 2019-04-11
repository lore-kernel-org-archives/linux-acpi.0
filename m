Return-Path: <SRS0=iZuV=SN=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A96C10F13
	for <linux-acpi@archiver.kernel.org>; Thu, 11 Apr 2019 18:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BAC2083E
	for <linux-acpi@archiver.kernel.org>; Thu, 11 Apr 2019 18:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDKSlY (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:41:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:13356 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfDKSlX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 Apr 2019 14:41:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 11:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,338,1549958400"; 
   d="scan'208";a="148442189"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2019 11:36:23 -0700
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.68]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.76]) with mapi id 14.03.0415.000;
 Thu, 11 Apr 2019 11:36:22 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 3/8] ACPICA: Rename nameseg length macro/define for
 clarity
Thread-Topic: [PATCH 3/8] ACPICA: Rename nameseg length macro/define for
 clarity
Thread-Index: AQHU7k0JS3XoAACCIkelRDDDNr/5cqY0BkQAgANH+GA=
Date:   Thu, 11 Apr 2019 18:36:22 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C5A1445@ORSMSX122.amr.corp.intel.com>
References: <20190408204230.4335-1-erik.schmauss@intel.com>
 <20190408204230.4335-4-erik.schmauss@intel.com>
 <CAJZ5v0j1ondAX_jK==YaoPdejDeinb7cirBR2W6H89uAx7crMA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j1ondAX_jK==YaoPdejDeinb7cirBR2W6H89uAx7crMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYWNwaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1hY3BpLQ0KPiBvd25lckB2Z2VyLmtlcm5l
bC5vcmddIE9uIEJlaGFsZiBPZiBSYWZhZWwgSi4gV3lzb2NraQ0KPiBTZW50OiBUdWVzZGF5LCBB
cHJpbCA5LCAyMDE5IDI6MzAgQU0NCj4gVG86IFNjaG1hdXNzLCBFcmlrIDxlcmlrLnNjaG1hdXNz
QGludGVsLmNvbT4NCj4gQ2M6IEFDUEkgRGV2ZWwgTWFsaW5nIExpc3QgPGxpbnV4LWFjcGlAdmdl
ci5rZXJuZWwub3JnPjsgUmFmYWVsIEouDQo+IFd5c29ja2kgPHJqd0Byand5c29ja2kubmV0Pjsg
TW9vcmUsIFJvYmVydA0KPiA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAzLzhdIEFDUElDQTogUmVuYW1lIG5hbWVzZWcgbGVuZ3RoDQo+IG1hY3JvL2RlZmlu
ZSBmb3IgY2xhcml0eQ0KPiANCj4gT24gTW9uLCBBcHIgOCwgMjAxOSBhdCAxMDo1MiBQTSBFcmlr
IFNjaG1hdXNzDQo+IDxlcmlrLnNjaG1hdXNzQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBG
cm9tOiBCb2IgTW9vcmUgPHJvYmVydC5tb29yZUBpbnRlbC5jb20+DQo+ID4NCj4gPiBBQ1BJQ0Eg
Y29tbWl0IDI0ODcwYmQ5ZTczZDcxZTJhMWZmMGExZTk0NTE5ZjhmODQwOWU1N2QNCj4gPg0KPiA+
IEFDUElfTkFNRV9TSVpFIGNoYW5nZWQgdG8gQUNQSV9OQU1FU0VHX1NJWkUgVGhpcyBjbGFyaWZp
ZXMgdGhhdA0KPiB0aGlzDQo+ID4gaXMgdGhlIGxlbmd0aCBvZiBhbiBpbmRpdmlkdWFsIG5hbWVz
ZWcsIG5vdCB0aGUgbGVuZ3RoIG9mIGEgZ2VuZXJpYw0KPiA+IG5hbWVzdHJpbmcvbmFtZXBhdGgu
DQo+ID4gSW1wcm92ZXMgdW5kZXJzdGFuZGluZyBvZiB0aGUgY29kZS4NCj4gPg0KPiA+IExpbms6
IGh0dHBzOi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNwaWNhL2NvbW1pdC8yNDg3MGJkOQ0KPiA+IFNp
Z25lZC1vZmYtYnk6IEJvYiBNb29yZSA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBFcmlrIFNjaG1hdXNzIDxlcmlrLnNjaG1hdXNzQGludGVsLmNvbT4NCj4gDQo+
IFRoaXMgbWlzc2VkIHNvbWUgTGludXgtc3BlY2lmaWMgZmlsZXMgcmVmZXJyaW5nIHRvIEFDUElf
TkFNRV9TSVpFLA0KPiBidXQgSSBmaXhlZCBpdCB1cC4NCg0KVGhhbmtzIGZvciBjYXRjaGluZyBp
dCENCg==
