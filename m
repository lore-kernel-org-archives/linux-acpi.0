From: Florian =?ISO-8859-15?Q?H=FChn?= <acpi-14TN6mYQPXr1AXQ8ov2VOh2eb7JE58TQ@public.gmane.org>
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Thu, 21 Oct 2004 18:19:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041021181947.778cce6f.acpi@trafficmanager.org>
References: <20041018020816.48673359@localhost.localdomain>
	<20041018112632.GB4400@openzaurus.ucw.cz>
	<20041021001331.69c6c965@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041021001331.69c6c965-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> I do hit the video problem though. I've tried the stuff in
> power/video.txt, but mine doesn't seem to be among the few systems
> with a solution at the moment. I don't have a Radeon, so I haven't
> tried the radeonfb-patch that's been floating around
> (http://www.loria.fr/~thome/d600/), but the part that mentions "you
> may insert a similar call from the vesa frame buffer driver to obtain
> similar results for a wide range of cards" intrigues me. Could this be
> something to try? Or is this already what acpi_sleep=s3_bios does?

Did you try passing "acpi_sleep=s3_bios acpi_sleep=s3_mode" as the
kernel boot parameters? The ability of passing both at the same time
isn't mentioned in the video.txt but it did the trick or me. (vaio
fx505)


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
