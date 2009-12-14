From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [PATCH]acpi c-states: Fix ACPI C3 is wrongly mapped to C2
Date: Mon, 14 Dec 2009 11:12:20 -0800
Message-ID: <E9B3B63B4561864CB95EB36DAD19BB2D5819FF2C@orsmsx505.amr.corp.intel.com>
References: <20091212181442.GA22832@youquan-linux.bj.intel.com>
 <20091212142727.GA6867@comet.dominikbrodowski.net>
 <20091212235549.GA7753@youquan-linux.bj.intel.com>
 <20091213084317.GA15989@isilmar.linta.de>
 <20091214100200.GA17243@youquan-linux.bj.intel.com>
 <20091214131255.GA4126@youquan-linux.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2430 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932379AbZLNTHi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Dec 2009 14:07:38 -0500
In-Reply-To: <20091214131255.GA4126@youquan-linux.bj.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Youquan,Song" <youquan.song@linux.intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, "lenb@kernel.org" <lenb@kernel.org>, "Liu, Kent" <kent.liu@intel.com>, "Guo, Chaohong" <chaohong.guo@intel.com>, "Song, Youquan" <youquan.song@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

 

>-----Original Message-----
>From: Youquan,Song [mailto:youquan.song@linux.intel.com] 
>Sent: Monday, December 14, 2009 5:13 AM
>To: linux@dominikbrodowski.net
>Cc: Dominik Brodowski; lenb@kernel.org; Pallipadi, Venkatesh; 
>Liu, Kent; Guo, Chaohong; Song, Youquan; linux-acpi@vger.kernel.org
>Subject: Re: [PATCH]acpi c-states: Fix ACPI C3 is wrongly mapped to C2
>
>> > Yes, but what happens if there are two states of type C2? 
>The whole concept
>> > of "type C<number>" and "state C<number>" was broken from 
>the beginning...
>> 
>> Sorry. In my mind, there is no two states of ACPI C2. If processor C3
>> above are mapped to ACPI C3, so processor C1 is mapped to ACPI C1,
>> processor C2 is mapped to ACPI C2.  
>> Len Brown, Am I right?
>> 
>> If I am wrong, I will file another patches for it.  
>
>This patch handle the ACPI C2 invlidation on some platform.
>Another patch "acpi c-states: Fix multiply C-states name
>disturbance" will unify multiply C-states name.
>

I assume this patch is not needed with your other patch
"acpi c-states: Fix multiply C-states name
disturbance".

I don't like
/proc/acpi/processor/CPUx/power
    C1:                  type[C1] promotion[--] demotion[--] 
    C2:                  <not supported>
    C3:                  type[C3] promotion[--] demotion[--] 

Because there are systems with more than one ACPI C3 C-state and this change will not help such systems. Also, this has potential to break applications like powertop that depend on current output format.

Thanks,
Venki