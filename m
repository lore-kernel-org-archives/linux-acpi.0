From: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Subject: Re: ACPI on the Compaq Presario 2800T
Date: Fri, 26 Jul 2002 20:49:55 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200207270049.UAA22638@cathedral-seven.mit.edu>
References: <20020726101631.GA25511@clara.net>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Fri, 26 Jul 2002 11:16:32 BST."
             <20020726101631.GA25511-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Sourav K Mandal [smandal-DPNOqEs/LNQ@public.gmane.org] wrote:


> There is no "fan" entry because the laptop seems to take care of that
> itself on my system although I wish I could override it and have it run
> a little cooler.  Battery probably doesn't appear because of
> nocorruption.2 missing... so perhaps you don't need:

I have done 2.4.18+acpi-20020709+nocorruption-2+sleep+swsusp+packet-cd.

Suspend seems to work, but no battery indicator.

> You'll probably have to come up with this yourself but you are welcome
> to get the diff from my webpage as your bugs are possibly similar to the
> ones in my DSDT.
> 
> http://dude.noc.clara.net/~faye/compaq2701ea/

Thanks! I might have too look at it to get ideas ...

> I recently helped someone get their DSDT patched via IRC and learned a
> few more likely bugs so I'm thinking of putting all this reasoning on a
> page - a proto DSDT patching howto if you like.

That'd be sweet for newbies like myself

> There was a choice of WXP, NT5S, W98S and WME
> Is there an official "Best host OS to fake" for this situation?
> The only thing I can think of is that this setting makes certain things
> remain under the BIOS control because of the way that the OS handles
> them?

Interesting ... seems like trial-and-error is the best strategy.


Sourav


> 
> 
> Faye
> 
> -- 
> Faye Pearson,
> Software Development Manager,
> ClaraNET Ltd.       Tel 020 7903 3000
> 
> Life sucks, but death doesn't put out at all.
> 		-- Thomas J. Kopp



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
