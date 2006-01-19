From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.15-mm2 (acpi-cpufreq not loading)
Date: Thu, 19 Jan 2006 16:06:47 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CA52@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr14.intel.com ([192.55.52.68]:15795 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422641AbWASVGv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2006 16:06:51 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brice Goglin <Brice.Goglin@ens-lyon.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org

Brice,

>>Can you test the _PDC patch here all by itself?
>>
>>http://bugzilla.kernel.org/show_bug.cgi?id=5483#c17
>>
>>  
>>
>Yes, 2.6.15 +
>http://bugzilla.kernel.org/attachment.cgi?id=6731&action=view is also
>broken.
>
>>If this patch is what causes the failure, please 
>>build with CONFIG_ACP_DEBUG=y and attach the dmesg
>>from the failure, as well as the output from acpidump,

The dmesg you attached doesn't show a message showing
that acpi-cpufreq failed to load.

-Len
