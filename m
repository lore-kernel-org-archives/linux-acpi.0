From: Daniel Gryniewicz <dang-i4I+0k6VHanR7s880joybQ@public.gmane.org>
Subject: Re: [ACPI][2.6.10-rc3][SUSPEND] S3 mode - Cannot resume
	from PCI devices
Date: Thu, 16 Dec 2004 13:15:24 -0500
Message-ID: <1103220924.23829.8.camel@athena.fprintf.net>
References: <200412100315.21725.shawn.starr@rogers.com>
	 <20041214110648.GA2291@elf.ucw.cz>
	 <1103039717.10857.53.camel@athena.fprintf.net>
	 <20041214181819.GB5267@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041214181819.GB5267-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-12-14 at 19:18 +0100, Pavel Machek wrote:
> Hi!
> 
> > > > This isn't a nice regression.
> > > 
> > > So what was the last kernel where it worked?
> > 
> > For me, 2.6.9-rc4.  I've tried every -rc and -mm since, and it cannot
> > resume.  (I get no video on resume, even with 2.6.9-rc4, until X
> 
> Okay, perhaps you are lucky, diff between 2.6.9-rc4 and 2.6.9
> should be fairly small. Could you find which changeset is responsible?
> bkcvs should be really usefull here.
> 
> 				Pavel

So, I started out by building 2.6.9 to test it failed.  It failed.
Then, I started binary searching between 2.6.9-rc4 and 2.6.9, and worked
my way all the way back up to 2.6.9 with it working.  I'm now running
the current CVS as of yesterday, with no problems, and with suspend and
resume working.  I have no idea what changed between the original build
of 2.6.9 that failed, and the final build that worked, but it would
appear to have been something that was my fault.

Now if I could only get 10-rc4-ck1 to not hang on boot...

Daniel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
