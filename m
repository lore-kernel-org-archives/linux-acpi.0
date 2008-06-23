From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 04/10] acpi: adjust
 _acpi_{module,function}_namedefinitions
Date: Mon, 23 Jun 2008 12:45:23 -0700
Message-ID: <20080623124523.76f38d90.akpm@linux-foundation.org>
References: <200805010952.m419q3Jc031806@imap1.linux-foundation.org>
	<1209722812.22514.28.camel@linux-2bdv.site>
	<20080502054113.4e5839d9.akpm@linux-foundation.org>
	<1209737075.22514.79.camel@linux-2bdv.site>
	<9D39833986E69849A2A8E74C1078B6B3446FBD@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49640 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755364AbYFWTpb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jun 2008 15:45:31 -0400
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B3446FBD@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: trenn@suse.de, linux-acpi@vger.kernel.org, jbeulich@novell.com

On Sun, 4 May 2008 12:14:41 -0700
"Moore, Robert" <robert.moore@intel.com> wrote:

> >But in future, such patches should definitely be based against ACPICA
> >code. Len will probably announce here where to find the very latest
> >sources, soon. Currently the latest official release linked to on
> >http://lesswatts.org is still from 2006. AFAIK things will get better
> >here, soon.
> >
> >   Thomas
> 
> 
> The latest ACPICA source can be found at the acpica.org website. In
> fact, we have converted our source repository from CVS to git, and the
> actual working git repository is now publicly available at
> 
> http://www.acpica.org/repos/acpica.git/
> 
> The acpica.org website was created at the end of 2007, and is now the
> home of the acpica project.
> 

OK, I'm now peeved.

I've sent this patch ten damned times now and only once was there any
comment and it was this vague indecisive wafflefest from which I now
discover I was removed from Cc.

Well someone has now merged something else which wrecked this patch
whcih I've been maintaining (for you guys!) for over two months. 

I'll drop it.  Please try harder.
