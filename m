From: Tomi Kallio <tomi-y4dnIKzCb/d9YMlOZIriJw@public.gmane.org>
Subject: Re: Radeon M7 and resuming from suspend-to-ram
Date: Fri, 14 Jan 2005 22:06:17 +0200
Message-ID: <41E82639.1020802@sllpilots.fi>
References: <41E7D334.6060003@sllpilots.fi> <1105716379.5148.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1105716379.5148.8.camel@localhost>
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

> Probably already tried this but:
> 
> Here at work we use an ACPID script that simply runs "radeontool light
> on" after a resume. Also, you might trying "chvt 1" or similar before
> suspend and chvt'ing back to whatever TTY X is on upon resume.

I tried "radeontool light on", but it has no effect. When using external 
display I'm able to power it off using radeontool. At the moment resume 
from suspend-to-ram works from X (xorg and Gentoo's patches) using 
external display and suspend/resume from X is enough for me. Only 
problem is that I'm unable to get laptop's own display working after 
resume, only external works.

Tomi


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
