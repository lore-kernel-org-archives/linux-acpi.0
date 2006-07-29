From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Sat, 29 Jul 2006 14:35:16 +0300
Message-ID: <41840b750607290435x379fe818t2df5c2d4ffd4125e@mail.gmail.com>
References: <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com>
	 <20060729103707.26737.qmail@web36908.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:49393 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932650AbWG2Lfa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Jul 2006 07:35:30 -0400
Received: by ug-out-1314.google.com with SMTP id m3so104147ugc
        for <linux-acpi@vger.kernel.org>; Sat, 29 Jul 2006 04:35:29 -0700 (PDT)
In-Reply-To: <20060729103707.26737.qmail@web36908.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Underwood <basicmark@yahoo.com>
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>, Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On 7/29/06, Mark Underwood <basicmark@yahoo.com> wrote:
> > The lazy polling approach I described in my last post to Vojtech
> > ("block until there's  a new readout or N milliseconds have passed,
> > whichever is later") looks like a more general, accurate and efficient
> > interface.
>
> This sounds like a good idea. You could do a similar thing using sysfs by
> providing a entry in sysfs which tells userland when the next update is going
> to happen, the userland app can then decide to use this as it's next poll time
> or not.

The driver may not know when the next update will happen, e.g., if its
data source is event-based. Moreover, the driver may be able to
*decide* when the next update will happen (i.e., when to query
poll-based hardware) if the clients say what they need in advance. The
"lazy poll" / "reverse select" handles both of these.

  Shem
