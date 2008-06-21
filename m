From: "Jeff Trull" <linmodemstudent@gmail.com>
Subject: Re: no self-refresh during S3 - any debug hints?
Date: Fri, 20 Jun 2008 23:13:06 -0700
Message-ID: <685450530806202313v4ec63bc8n5213330d77e1b6d@mail.gmail.com>
References: <685450530805311215lf463875g8eed40da630b4f96@mail.gmail.com>
	 <alpine.LFD.1.10.0806191437580.3040@localhost.localdomain>
	 <20080619201052.GA15587@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:59872 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbYFUGNK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Jun 2008 02:13:10 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1534553fkq.5
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jun 2008 23:13:07 -0700 (PDT)
In-Reply-To: <20080619201052.GA15587@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu, Jun 19, 2008 at 1:10 PM, Pavel Machek <pavel@suse.cz> wrote:

>
> Hmm, or some other hardware... I ve seen machines where video ram was
> not refreshed. If that piece of hw is critical enough, it will break
> resume.
>
> You could try with minimal system, with as little drivers as
> possible... use acpi_sleep=s3_beep to determine where it fails.
>                                                                        Pavel

I don't have ready access to 2.6.26, but with 2.6.24 s3_beep produces
a (endless, loud) tone if I resume immediately after suspend, and
nothing at all if I wait 10 seconds first.

Jeff
