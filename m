From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Debug interface used for error message cleanups
Date: Thu, 31 Jul 2008 14:42:13 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B3C3CFB3@orsmsx415.amr.corp.intel.com>
References: <1217449342-20312-1-git-send-email-trenn@suse.de> <9D39833986E69849A2A8E74C1078B6B3BFA624@orsmsx415.amr.corp.intel.com> <200807311159.11276.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64750 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941AbYGaVmP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jul 2008 17:42:15 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200807311159.11276.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>

>If you are at that, do you think it makes sense to intruduce a GPE
>bit?

How about something a bit more generic - ACPI_DB_EVENTS. This could be
used for both the fixed events and the GPEs.


>-----Original Message-----
>From: Thomas Renninger [mailto:trenn@suse.de]
>Sent: Thursday, July 31, 2008 2:59 AM
>To: Moore, Robert
>Cc: ak@linux.intel.com; lenb@kernel.org; linux-acpi@vger.kernel.org;
Zhang,
>Rui
>Subject: Re: Debug interface used for error message cleanups
>
>On Wednesday 30 July 2008 22:29:19 Moore, Robert wrote:
>> I'm going to go ahead and remove these from ACPICA.
>>
>> We added an "obsolete" warning in the header file some time ago, and
I
>> think the time has come to remove them, especially in light of these
>> patches to Linux.
>
>Great thanks.
>If you are at that, do you think it makes sense to intruduce a GPE
>bit?
>Just leaving it unused for now?
>
>I didn't play with these much yet, Rui, do you think this makes sense?
The
>fact there were several sever problems recently and GPEs possibly
>must get debugged by people writting other device drivers who do not
know
>and do not want to know about the output of the other debug flags I
thought
>this could make sense.
>
>Just an idea...,
>
>       Thomas
