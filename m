From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Re: ACPI - SWSUSP interaction
Date: Fri, 09 May 2003 20:27:43 +1200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1052389484.1754.33.camel@laptop-linux>
References: <Pine.LNX.4.21.0305071429500.7835-100000@vista.rtm.home>
 <16058.16.254227.882114@hotzenplotz.chateau-neukoelln.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <16058.16.254227.882114-/D6BEnooUbBSBwh6+m2SNzw7hsPlABbXrfATN7qnIZ4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stephan Krings <Stephan.Krings-Mmb7MZpHnFY@public.gmane.org>
Cc: Rob Miller <rob-7HoZ3oJp7ZtBDgjK7y7TUQ@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

There's no interaction between swsusp and ACPI at present. Neither, I
believe, should there be (2.5 is a different story, since it has the
driver model). If it's possible for ACPI to properly check the status
(and I'd be surprised if its not possible), it should do so rather than
storing the state in a variable. Since its not done in this way at the
moment, I'd _assume_ some deficiency(sp?) in the ACPI spec (rather than
that Andy et al have tried to take a shortcut) or that it's done this
way as an optimisation.

Regards,

Nigel

On Thu, 2003-05-08 at 18:58, Stephan Krings wrote:
> Hi,
> 
> > In any event, I think there is an issue that one or more folk here may be
> > able to help with.  It appears to me that reads of at least the following
> > /proc entries do not actually test the hardware state, but rely on
> > detecting ACPI events to trigger changes in stored information:
> 
> [ ... ]
> 
> > Question 1:  Is my conclusion above accurate, or have I run into an
> > idiosyncrasy of the laptop?
> 
> No, I can confirm your observation. I'm also using both ACPI and the
> swsusp patches for 2.4. When the machine is suspended and the AC
> adapter changes state, this change will not be recognized upon resume.
> 
> I'd guess that the ACPI code stores the state somewhere in memory and
> will only change it, when the ACPI BIOS generates events.
> 
> I think the ACPI code should just reexamine some values after
> resume. This will require quite a lot of integration between swsusp
> and ACPI and I'm not sure, if this integration is already present.
> 
> Regards,
> 
> Stephan
> 
> 
> 
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
> The only event dedicated to issues related to Linux enterprise solutions
> www.enterpriselinuxforum.com
> 
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
