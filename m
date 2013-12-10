From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI / blacklist: disable Win8 mode for ThinkPad X201
 and Latitude E6230
Date: Tue, 10 Dec 2013 11:05:21 +0800
Message-ID: <52A684F1.7070502@intel.com>
References: <52A15F72.1050408@intel.com> <20131209165817.GA30717@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3493 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054Ab3LJDFm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Dec 2013 22:05:42 -0500
In-Reply-To: <20131209165817.GA30717@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Jeffery To <jeffery.to@gmail.com>, Wouter Depypere <wouter.depypere@ugent.be>

On 12/10/2013 12:58 AM, Matthew Garrett wrote:
> On Fri, Dec 06, 2013 at 01:24:02PM +0800, Aaron Lu wrote:
>>  	/*
>> +	 * The bluetooth functionality is unconditionally enabled
>> +	 * after a S3 cycle on Thinkpad X201 under Win8 mode.
>> +	 */
> 
> Can you describe this in a little more detail? Does the thinkpad-acpi 
> rfkill code just not work?

Yes it works, the problem is, even the bluetooth is disabled before
hibernate, it will be enabled after resume.

As Jeffery has put in comment #14:
"
With thinkpad_acpi blacklisted, Bluetooth is enabled on boot. I can't
turn it off unless I run "modprobe thinkpad_acpi" beforehand. After
turning Bluetooth off, I ran "rmmod thinkpad_acpi" before hibernating.
I verified that thinkpad_acpi isn't loaded (with lsmod) before hibernating
and after resuming. Bluetooth is enabled on resume.

I tried this same test with the acpi_osi="!Windows 2012" kernel
parameter (and thinkpad_acpi blacklisted). Bluetooth is disabled on boot.
I verified that thinkpad_acpi isn't loaded (with lsmod) before
hibernating and after resuming. Bluetooth is disabled on resume.
"

But I made a mistake in the comment, it's a S4 cycle, not a S3.

> 
>> +	/*
>> +	 * The hardware switch for enable/disable wifi on
>> +	 * Dell Latitude E6230 is broken under Win8 mode.
>> +	 */
> 
> Can you define "broken"? Do you see the same behaviour under Windows 8?

As Wouter has put in comment #12:
"
I also have trouble with this commit, it disables my hardware switch for
enable/disable wifi. See [1] for full explanation.

When I add acpi_osi="!Windows 2012" it fixes my issue.
"
