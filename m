From: Tony Luck <tony.luck@gmail.com>
Subject: Re: Parameter check for EINJ error injection - V3
Date: Sat, 29 Jun 2013 11:29:56 -0700
Message-ID: <07891708-A90B-4367-A391-C18F4DA8B3F1@gmail.com>
References: <1369276323-31436-1-git-send-email-gong.chen@linux.intel.com> <20130629085846.GA4426@gchen.bj.intel.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:37327 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab3F2SaA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Jun 2013 14:30:00 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so1647348pde.32
        for <linux-acpi@vger.kernel.org>; Sat, 29 Jun 2013 11:30:00 -0700 (PDT)
In-Reply-To: <20130629085846.GA4426@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: "tony.luck@intel.com" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Look in "tip" tree (x86/ras branch).

-Tony

Sent from my iPhone

On Jun 29, 2013, at 1:58, Chen Gong <gong.chen@linux.intel.com> wrote:

> On Wed, May 22, 2013 at 10:32:01PM -0400, Chen Gong wrote:
>> Date:    Wed, 22 May 2013 22:32:01 -0400
>> From: Chen Gong <gong.chen@linux.intel.com>
>> To: tony.luck@intel.com, bp@alien8.de
>> Cc: linux-acpi@vger.kernel.org
>> Subject: Parameter check for EINJ error injection - V3
>> X-Mailer: git-send-email 1.7.10.4
>> 
>> [PATCH 1/2 V3] ACPI/APEI: Add parameter check before error injection
>> [PATCH 2/2 V3] ACPI/APEI: Update einj documentation for param1/param2
>> 
>> These two patches are employed to enhance the check for param1/param2
>> when einj is used. Param1/param2 are very subtle for the guy
>> who lacks of experience. These two patches add some extra checks to
>> avoid happening further errors to confuse users.
>> 
>> V3: only update the 1st patch based on Tony and Boris' suggestion.
>> V2: only update the 1st patch based on Boris' suggestion.
>> --
> 
> So Tony/Boris
> 
> Have you picked this patch series into some RAS branch? I just don't
> find them.
> 
