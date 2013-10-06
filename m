From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] acpi: update win8 OSI blacklist
Date: Sun, 6 Oct 2013 15:29:10 -0500
Message-ID: <CAMP44s0tqKBgUTzFnbTMqDVVWLcaDC5VKd9mq_w+T_Yu19KXqQ@mail.gmail.com>
References: <1380820383-23336-1-git-send-email-felipe.contreras@gmail.com>
	<20131004161226.GA22784@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131004161226.GA22784@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 4, 2013 at 11:12 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Thu, Oct 03, 2013 at 12:13:03PM -0500, Felipe Contreras wrote:
>> More people have reported they need this for their machines to work
>> correctly.
>
> Can you add a comment to each indicating why they're being added so we
> can easily remove them again once the problem is fixed?

Because that's what users report:
https://bugzilla.kernel.org/show_bug.cgi?id=60682

-- 
Felipe Contreras
