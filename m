From: raz ben yehuda <razb@bitband.com>
Subject: RE: 	Subject: [PATCH 1/2] linux-acpi: sos documentation
Date: Sat, 18 Oct 2008 03:37:35 +0200
Message-ID: <1224293855.3652.36.camel@raz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fw.bitband.com ([213.8.50.174]:12655 "EHLO mail.bitband.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750972AbYJRBhn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Oct 2008 21:37:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pavel@suse.cz
Cc: lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

First , I really really thank you for replying, This is not the first post I made for sos.
For some reason I did not get your reply.

On Tue 2008-10-14 01:38:13, raz ben yehuda wrote:
> From: Raz Ben Yehuda <razb@bitband.com>
> 
> Signed-off-by: Raz Ben Yehuda <razb@bitband.com>
> ---

>>No changelog, useful...
Do you mean diffstat ?  I added diffstat at the sos-api patch. . 
Are you referring to Documentation/Changes ?  I am not sure I know what you mean.

> diff -urpN linux-2.6.27/Documentation/SOS.txt linux-2.6.27-dbg/Documentation/SOS.txt
> --- linux-2.6.27/Documentation/SOS.txt	1970-01-01 02:00:00.000000000 +0200
> +++ linux-2.6.27-dbg/Documentation/SOS.txt	2008-10-14 00:29:32.000000000 +0200
> @@ -0,0 +1,14 @@
> +				SOS
> +
> +SOS is a service oriented scheduler. SOS is a method of relating one or more
> +distinct services to a processor.In other words, a core(s) is assigned to
> +a chore, not a chore to a core.
> +Technically speaking, by virtually removing a processor from the operating
> +system, using Linux ACPI facility one can bind processors to services.
> +SOS management and control is done by sosctl.
> +To fully understand what is SOS, when should it be used it and for which
> +puprose,please refer to http://sos-linux.cvs.sourceforge.net/sos-linux/sos/Documentation/.
> +

>>I don't think this should be acpi specific... and you should provide
>>real doc, not pointer to web page.
1. I posted to lkml as well as acpi. is this what you mean ?
2. At first, I posted a big text file , but I got zero replies so i thought that maybe people refrain from reading so much.
   But I will fix it (I read SubmittingPatches). 

>>Plus select some better acronym.
>>									Pavel
How about ops ( offload-processor scheduler ) ? any other suggestions ? well.. I am bad at names.   
 
raz



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
