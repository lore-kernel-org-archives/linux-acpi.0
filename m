From: Jeremy Moles <jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org>
Subject: Re: Radeon M7 and resuming from suspend-to-ram
Date: Fri, 14 Jan 2005 10:26:19 -0500
Message-ID: <1105716379.5148.8.camel@localhost>
References: <41E7D334.6060003@sllpilots.fi>
Reply-To: jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41E7D334.6060003-y4dnIKzCb/d9YMlOZIriJw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Probably already tried this but:

Here at work we use an ACPID script that simply runs "radeontool light
on" after a resume. Also, you might trying "chvt 1" or similar before
suspend and chvt'ing back to whatever TTY X is on upon resume.

That's worked sometimes too.

On Fri, 2005-01-14 at 16:12 +0200, Tomi Kallio wrote:
> Hello.
> 
> I'm running gentoo on Compaq Evo N800V laptop with radeon M7. At the 
> moment I'm using gentoo-dev-sources version 2.6.10-r4. For the first 
> time suspend-to-ram almoust works but I'm having trouble resuming 
> radeon/screen. After resuming, display on laptop stays black with just 
> "weak" backlight but if I plug in external monitor, then external 
> monitor is working normally but laptop's display stays black. So the 
> resume from X "works". If I switch to console then external monitor 
> complaints about invalid mode while laptop's display stays black. With 
> radeontool I can normally power down/up external output, but display on 
> laptop stays blank no matter what I do. I have also tried boot-radeon in 
> console that should reset video bios, but it doesn't work either.
> 
> Any ideas?
> 
> Tomi
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
