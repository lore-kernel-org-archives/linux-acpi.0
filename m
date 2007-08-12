From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
Subject: Re: v2.6.23-rc2 locks up during boot (without acpi=off)
Date: Sun, 12 Aug 2007 23:48:12 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0708122342330.25832@kivilampi-30.cs.helsinki.fi>
References: <Pine.LNX.4.64.0708012131480.1479@kivilampi-30.cs.helsinki.fi>
 <20070812012826.cfc9f5bb.akpm@linux-foundation.org>
 <Pine.LNX.4.64.0708121154150.31747@kivilampi-30.cs.helsinki.fi>
 <20070812092708.23d0c21c.akpm@linux-foundation.org>
 <Pine.LNX.4.64.0708122003590.25605@kivilampi-30.cs.helsinki.fi>
 <20070812102754.a785e78a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; boundary="-696243703-1716754897-1186951605=:25832"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from courier.cs.helsinki.fi ([128.214.9.1]:52458 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbXHLUsO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Aug 2007 16:48:14 -0400
In-Reply-To: <20070812102754.a785e78a.akpm@linux-foundation.org>
Content-ID: <Pine.LNX.4.64.0708122347150.25832@kivilampi-30.cs.helsinki.fi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696243703-1716754897-1186951605=:25832
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0708122347151.25832@kivilampi-30.cs.helsinki.fi>

On Sun, 12 Aug 2007, Andrew Morton wrote:

> On Sun, 12 Aug 2007 20:15:51 +0300 (EEST) "Ilpo Järvinen" <ilpo.jarvinen@helsinki.fi> wrote:
> 
> > Hmm, it was really worth of it, I did:
> > $ git-fetch linus
> > $ git-reset --hard linus
> > [...make & install & boot...]
> > 
> > ...and voila, the problem went away, so something else seems to have
> > fixed it between: ac07860264bd and 963c6527e0a0e. As you can notice,
> > I didn't even have to revert it (I was just double checking current
> > mainline first).
> > 
> > Is there a need to get a more detailed view about the cause or something, 
> > or are details of this issue clear enough to everyone? I can do some more 
> > research if necessary, though expect a bit longer latencies during the 
> > next week...
> > 
> > In case none, thanks everyone, this issue seems solved. :-)
> 
> We just had an acpi commit.  Something like ed3110efb538d7acbf635095c1382118f7414f75
> might have fixed this.

...Yeah, it's very likely the same issue as bisect in that case seemed to 
end up to the very same commit I found, and it was answered with that 
fix...

-- 
 i.
---696243703-1716754897-1186951605=:25832--
