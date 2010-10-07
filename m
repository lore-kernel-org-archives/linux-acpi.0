From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] ACPI: Read TSC upon resume
Date: Thu, 7 Oct 2010 11:15:36 -0700
Message-ID: <20101007181536.GA24811@suse.de>
References: <1286406919-6236-1-git-send-email-snanda@chromium.org>
 <20101007021959.GA7300@suse.de>
 <AANLkTimE2h46iZkj_amvgUg5UwN9xjuwqdW5TB+XccYy@mail.gmail.com>
 <20101007174626.GA31541@suse.de>
 <AANLkTik=imw5XRpXSkboyB6txXio6Y65bLV+EdfvRXg3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:49840 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840Ab0JGSPv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Oct 2010 14:15:51 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik=imw5XRpXSkboyB6txXio6Y65bLV+EdfvRXg3@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sameer Nanda <snanda@chromium.org>
Cc: lenb@kernel.org, stefan.bader@canonical.com, brad.figg@canonical.com, apw@canonical.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 07, 2010 at 11:05:21AM -0700, Sameer Nanda wrote:
> On Thu, Oct 7, 2010 at 10:46 AM, Greg KH <gregkh@suse.de> wrote:
> > On Thu, Oct 07, 2010 at 10:43:34AM -0700, Sameer Nanda wrote:
> >> On Wed, Oct 6, 2010 at 7:19 PM, Greg KH <gregkh@suse.de> wrote:
> >> > And are you always going to be printing this out? =A0Why do we w=
ant to
> >> > know this every time?
> >> >
> >>
> >> Yes, every time. =A0This helps track variance in BIOS resume times=
 within a
> >> single boot.
> >
> > Is that really something that users can do something about?
>=20
> Aside from complaining to the BIOS vendors, no :)

Then I would not recommend adding this patch, as it is irrelevant for
99.9999% of all Linux users.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
