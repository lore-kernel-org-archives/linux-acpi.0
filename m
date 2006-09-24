From: Timo Hoenig <thoenig@nouse.net>
Subject: RE: [PATCH 2.6.18 1/1] ACPI: limit cstate on noisy thinkpad t43/p
	models
Date: Sun, 24 Sep 2006 13:38:02 +0200
Message-ID: <1159097883.5437.12.camel@nouse.suse.de>
References: <CFF307C98FEABE47A452B27C06B85BB6018F099A@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:13986 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752005AbWIXLiW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Sep 2006 07:38:22 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6018F099A@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: shadow@serverart.org, linux-acpi@vger.kernel.org

Hi,

On Thu, 2006-09-21 at 18:05 -0400, Brown, Len wrote:

> Turning off C3 is a pretty big hammer...

Indeed.

I think it is a more general problem.  The systems with Intel Core Duo I
got my hands on all show the symptom:  Once the system is idle, the
second core begins to whine.  It's annoying in quiet environments.

      * Turning off the second core makes the whining stop.
      * Booting with processor.max_cstate=2 does also make the whining
        go away; but it's a bad idea on laptops if once wants to gain a
        long run on batteries.

Tested with HZ=250; I'll check whether HZ=100/1000 helps.

   Timo

