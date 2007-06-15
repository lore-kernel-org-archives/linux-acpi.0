From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch] Reporting the lid status using INPUT
Date: Fri, 15 Jun 2007 10:29:24 -0400
Message-ID: <d120d5000706150729i24763e00o7d2c48ef16960b2f@mail.gmail.com>
References: <1181910567.4819.7.camel@work> <1181913179.21041.3.camel@work>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.233]:45193 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbXFOO3Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jun 2007 10:29:25 -0400
Received: by qb-out-0506.google.com with SMTP id z8so659308qbc
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jun 2007 07:29:25 -0700 (PDT)
In-Reply-To: <1181913179.21041.3.camel@work>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, a_bartok@freemail.hu, Bastien Nocera <hadess@hadess.net>, David Zeuthen <david@fubar.dk>

On 6/15/07, Richard Hughes <hughsient@gmail.com> wrote:
> On Fri, 2007-06-15 at 13:29 +0100, Richard Hughes wrote:
> > in response to an event, but I'm thinking in a resume hook we should
> > probably do acpi_evaluate_integer(handle, "_LID", NULL, &state) and then
> > send an event, just so userspace is aware of what the state of the panel
> > is.
>
> Attached patch fixed the issue for me. Comments?
>

The patch makes perfect sense. The only issue I have is this:

> +	/* on resume we send the state; it might be the same, but userspace
> +	 * should handle duplicated events */

If switch state matches to what input layer thinks it is the event
will not even reach userspace.

-- 
Dmitry
