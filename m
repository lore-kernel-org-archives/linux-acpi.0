From: Stefan Behnel <behnel_ml-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>
Subject: Re: fan control
Date: Fri, 02 May 2003 11:24:02 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EB23932.9090508@gkec.tu-darmstadt.de>
References: <B900970C7DD9474C972986EB3EC7C58F12EC9A@andromeda.agcad.local> <20030502103102.A2867@fermat.unipv.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030502103102.A2867-xzhXYMPkGmXoPXhRcRtihA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Cc: Herbert Nachtnebel <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>, raul.aranda-fE4FmR91nWqXOwHavGvsmg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Daniele Boffi wrote:
> Indeed, it seem that after rebooting my machine forgets about the fact that I
> was playing with the fan status.

I'd be confused if it didn't.


> What I don't understand in Raul's message is
> why I should compile a new kernel.

He meant it as a stress test. Do something that demands a bit of CPU power to see if the fan jumps back on after you switched it off.


> The one I have is OK and does not seem to be
> screwed up by my experiments with the fan. Should it be? This is what seems
> like from Herbert's message.

No, see above.


> I don't want to make experiments with the risk of
> burning my CPU

That's why Raul suggested to keep an eye on the output of "acpi" while playing around with the fans.


>, but yesterday night (after a reboot) the (outside) temperature
> was low and the fan was off, even though in my previous experiment I put it in
> position one. This for me is the confirmation that everything is OK.

Sounds like you switched your computer off in between. Then, as I said, that's absolutely normal.


> What I
> don't know yet is whether this is OK also within the same session.

Try to find out then. As long as you keep an eye on the CPU temperature, you're unlikely to burn it.


> If there is
> any documentation about that, please let me know (for instance, I found echo 0
> and echo 3 just by guessing).

I don't know. But 0-5 are the general ACPI power states, 0 being "on" and "5" being "off". 1-4 are different shades in between.

Stefan



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
