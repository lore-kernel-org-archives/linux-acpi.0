From: emisca <emisca.ml@gmail.com>
Subject: Re: [0/5] remove ACPI motherboard driver, use PNP system driver instead (take 2)
Date: Fri, 9 Feb 2007 20:15:48 +0100
Message-ID: <414cba4e0702091115t472cc4b4s437b06ea7ffd6b71@mail.gmail.com>
References: <200701181636.45590.bjorn.helgaas@hp.com>
	 <200701291600.35739.bjorn.helgaas@hp.com>
	 <200701291819.26964.lenb@kernel.org>
	 <200701291624.16664.bjorn.helgaas@hp.com>
	 <414cba4e0701301218s708f4a7w3a2561cf77c7c617@mail.gmail.com>
	 <414cba4e0702031416p7b792addwf9cdbef797804136@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:15489 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992760AbXBITPu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Feb 2007 14:15:50 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1319126nfa
        for <linux-acpi@vger.kernel.org>; Fri, 09 Feb 2007 11:15:48 -0800 (PST)
In-Reply-To: <414cba4e0702031416p7b792addwf9cdbef797804136@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: emisca <emisca.ml@gmail.com>
Cc: linux-acpi@vger.kernel.org

I saw this error message using pnpacpi=off, on kernel boot, before resume:
PnPBIOS: Resource structure does not contain an end tag.

What does it means?

2007/2/3, emisca <emisca.ml@gmail.com>:
> I've finally found some time to do that test. I compiled kernel
> 2.6.20-rc6-mm3, and patched those files with your patch.
> Here are the
> I've finally found some time to do that test. I compiled kernel
> 2.6.20-rc6-mm3, and patched those files with your patch.
> Here are the dmesg, pre and post suspend. My serial continues to not
> work after resume, without using pnpacpi=off.
>
> I hope you'll find something useful on that dmesg dumps..
>
> 2007/1/30, emisca <emisca.ml@gmail.com>:
> > Sorry, I had no free time to try them on my motherboard.............. :-(
> > I hope to try them tomorrow evening.
> >
> > 2007/1/30, Bjorn Helgaas <bjorn.helgaas@hp.com>:
> > > On Monday 29 January 2007 16:19, Len Brown wrote:
> > > > On Monday 29 January 2007 18:00, Bjorn Helgaas wrote:
> > > > > Shaohua, Len, others,
> > > > >
> > > > > Did I resolve all the concerns you had about these patches?  Should
> > > > > I re-post them?
> > > >
> > > > Bjorn,
> > > > I didn't see any problems with them.
> > > >
> > > > On 1/24 I checked in your series posted on 1/18, and they've been in acpi-test since.
> > > > Sorry if I neglected to Ack them then -- sometimes I get interrupted and drop an Ack.
> > > > So unless you have an update since 1/18, then we're good.
> > >
> > > Nope, no updates since then.  Thanks!
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> >
>
>
