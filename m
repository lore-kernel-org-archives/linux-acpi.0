From: Proinnsias Breathnach <proinnsias-cv59FeDIM0c@public.gmane.org>
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Wed, 20 Oct 2004 10:45:31 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041020094531.GI13662@butler.project-bob.home>
References: <88056F38E9E48644A0F562A38C64FB600323619D@scsmsx403.amr.corp.intel.com> <20041019164702.GB25753@hottah.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041019164702.GB25753-Snhs3Gxj9njPHUqn3ntIkQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 19, 2004 at 06:47:02PM +0200, Luc Saillard wrote:
> On Tue, Oct 19, 2004 at 09:32:56AM -0700, Pallipadi, Venkatesh wrote:
>  
> > Which graphics controller do you have?
> Radeon Mobility M6
> > Are you using framebuffer with text console or simple VGA?
> no framebuffer, pure text console, and radeon graphics driver with xfree86.
> > Can you try acpi_sleep boot options (refer
> > Documentation/power/video.txt) for text console suspend-resume.
> Ok i'll try to call vga bios...
> 
Not sure this'll be much help - but something I was referred to on a
site about getting S3 working on a Dell D600 might be useful:

http://www.loria.fr/~thome/d600/

There's a patch there for the radeonFB that may solve your problem

-------------8<--------------
"The radeonfb patch does a real-mode call to the video bios, so that the
radeon performs the necesssary resume code when returning from sleep.
This is done from within the kernel, but has to be done at the proper
point, namely after PCI is reinitialized (which happens in protected
mode, so another pmode/rmode switch happens). There is nothing
radeon-specific in this code, but it's triggered from the radeon frame
buffer driver. You may insert a similar call from the vesa frame buffer
driver to obtain similar results for a wide range of cards (unless I'm
mistaken, this has pretty good chances of working). The radeon frame
buffer driver must be built into the kernel, and not built as a module,
since it must take over the console as early as possible."
-------------8<--------------

Might be useful to some ...

P


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
