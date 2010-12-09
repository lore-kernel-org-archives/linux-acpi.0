From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] X86: Revamp reboot behaviour to match Windows more
 closely
Date: Thu, 09 Dec 2010 14:32:52 -0800
Message-ID: <4D015914.1040009@zytor.com>
References: <1291931204-5854-1-git-send-email-mjg@redhat.com> <4D015741.7090500@zytor.com> <20101209223201.GA23894@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:48548 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630Ab0LIWc6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Dec 2010 17:32:58 -0500
In-Reply-To: <20101209223201.GA23894@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org

On 12/09/2010 02:32 PM, Matthew Garrett wrote:
> On Thu, Dec 09, 2010 at 02:25:05PM -0800, H. Peter Anvin wrote:
>> On 12/09/2010 01:46 PM, Matthew Garrett wrote:
>>> Windows reboots by hitting the ACPI reboot vector (if available), trying
>>> the keyboard controller, hitting the ACPI reboot vector again and then
>>> giving the keyboard controller one last go. Rework our reboot process a
>>> little to default to matching this behaviour, although we'll fall through
>>> to attempting a triple fault if nothing else works.
>>>
>>> Signed-off-by: Matthew Garrett<mjg@redhat.com>
>>
>> When this was discussed before we agreed to use ACPI reboot by default
>> with an ACPI cutoff date; this doesn't have any such cutoff.
>
> Windows doesn't either. Older machines simply won't have the appropriate
> flag set in their FADT.
>

Windows doesn't get validated on old hardware.

	-hpa

