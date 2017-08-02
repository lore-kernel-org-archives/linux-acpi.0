From: Joe Daily <Joe.Daily@advancedroboticsgroup.com>
Subject: ACPI Support for 32 Batteries
Date: Wed, 2 Aug 2017 18:00:15 +0000
Message-ID: <MWHPR1201MB009591C523610F3C0D0D30A6FEB00@MWHPR1201MB0095.namprd12.prod.outlook.com>
References: <MWHPR1201MB00953C1F674FD1A74E0C8A82FEB00@MWHPR1201MB0095.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-by2nam03on0066.outbound.protection.outlook.com ([104.47.42.66]:13251
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751956AbdHBSAQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Aug 2017 14:00:16 -0400
In-Reply-To: <MWHPR1201MB00953C1F674FD1A74E0C8A82FEB00@MWHPR1201MB0095.namprd12.prod.outlook.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Greetings,

I am working on a robot that uses 32 small li-ion batteries and would like =
for them report their charge status via ACPI.=20

Not being an APCI guru, I noticed in section 10.1.3 that it states that onl=
y 4 batteries are allowed. Does this mean that I cannot use ACPI for report=
ing all 32 battery statuses?=20

What is the recommend way of doing this?

Thanks=20

Joe Daily
