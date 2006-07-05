From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: not ACPI-aware installer
Date: Wed, 05 Jul 2006 22:27:56 +0400
Message-ID: <44AC04AC.8000008@linux.intel.com>
References: <449A709F.5010002@fmi.uni-passau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:57268 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S964974AbWGES2T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Jul 2006 14:28:19 -0400
In-Reply-To: <449A709F.5010002@fmi.uni-passau.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergiy Kolesnikov <kolesnik@fmi.uni-passau.de>
Cc: linux-acpi@vger.kernel.org

Sergiy Kolesnikov wrote:
> Hallow All,
> 
> if an OS knowing nothing about ACPI will be installed on a ACPI equiped 
> computer, can it cause a hardware damage?
> 
> I mean if it's true than an installer from some GNU/Linux distribution 
> that can't process thermal events from ACPI can lead to a hardware 
> damage during installation of the distribution. Am I thinking right?
> 
> Best regards,
> Sergiy Kolesnikov

It depends. Some computers allow one to disable ACPI in BIOS, in this case BIOS takes ownership of thermal zones and means to correct it (fans, throttling). In case than OS does not switch to ACPI operational mode (your case), BIOS should keep ownership of all above mentioned, but as all hardware is tested with ACPI-enabled Windows, in your particular case it can be damaged without ACPI... More problems arise than OS claims to support ACPI and then does not care about thermal, this is a recipe for disaster.

Regards,
	Alex. 
