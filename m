From: Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Thu, 21 Oct 2004 00:13:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041021001331.69c6c965@localhost.localdomain>
References: <20041018020816.48673359@localhost.localdomain>
	<20041018112632.GB4400@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041018112632.GB4400-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hey,

On Mon, 18 Oct 2004 13:26:33 +0200
Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:

> Hi!
> 
> Please wrap your messages at column 72
> 

Yeah, sorry about that. My newly installed sylpheed seems to have had
wrapping off by default; weird but true.

> 
> If battery needs to be reinserted, complain to sony. They have hw bug
> in there.
> 
> For debugging techniques... There's beeping patch from me floating
> around.
> 

Thanks, but with 2.6.9-final it actually does resume, so luckily I won't
have to suffer the beeping :)

I do hit the video problem though. I've tried the stuff in
power/video.txt, but mine doesn't seem to be among the few systems with
a solution at the moment. I don't have a Radeon, so I haven't tried the
radeonfb-patch that's been floating around
(http://www.loria.fr/~thome/d600/), but the part that mentions "you may
insert a similar call from the vesa frame buffer driver to obtain
similar results for a wide range of cards" intrigues me. Could this be
something to try? Or is this already what acpi_sleep=s3_bios does?

I'm on an Intel 855GM by the way.

Jon


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
