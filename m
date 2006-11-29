From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: new pmtools available for testing
Date: Wed, 29 Nov 2006 17:31:09 +0100
Message-ID: <20061129163109.GN4945@poupinou.org>
References: <B28E9812BAF6E2498B7EC5C427F293A401671EDA@orsmsx415.amr.corp.intel.com> <1164708222.4656.203.camel@queen.suse.de> <456C0E5A.5090703@linux.intel.com> <1164712459.4656.253.camel@queen.suse.de> <456C410D.9090201@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:57646 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S967469AbWK2Qem
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Nov 2006 11:34:42 -0500
Content-Disposition: inline
In-Reply-To: <456C410D.9090201@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: trenn@suse.de, "Moore, Robert" <robert.moore@intel.com>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Tue, Nov 28, 2006 at 05:00:45PM +0300, Alexey Starikovskiy wrote:
> Writing new utility from scratch took half a day, while porting ACPICA 
> acpidump with change in license would take weeks.
> It does include ACPICA types, so it will require ACPICA headers at least.
> Also it relies on ACPICA subset of libc, so it will be pain to both 
> maintain it  and  make any improvements.
> We already tried to have acpidump utility in both ACPICA and pmtools and 
> ended with two completely different programs.
> 

I don't get it.

ducrot@neptune:~/packages$ cp -r acpica-unix-20060912/tools/acpixtract/ .
ducrot@neptune:~/packages$ cd acpixtract/
ducrot@neptune:~/packages/acpixtract$ make
cc -Wall -O2 -D_LINUX -DACPI_APPLICATION -Wstrict-prototypes -I../../include    -c -o acpixtract.o acpixtract.c
cc  acpixtract.o -o acpixtract
ducrot@neptune:~/packages/acpixtract$ 

How acpixtract need ACPICA specific headers?

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
