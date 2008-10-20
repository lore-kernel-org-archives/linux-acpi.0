From: "Mike Dahlgren" <dahlgren@gmail.com>
Subject: Re: [PATCH] whitespace and comment cleanup for asus_acpi.c
Date: Mon, 20 Oct 2008 11:19:56 -0500
Message-ID: <b85328460810200919k64364713o5bbe0324a72c5e85@mail.gmail.com>
References: <b85328460810171100o28004af7v5b07db58258706e9@mail.gmail.com>
	 <alpine.LFD.1.10.0810171435230.3006@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:53129 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbYJTQT7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Oct 2008 12:19:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1448352fgg.17
        for <linux-acpi@vger.kernel.org>; Mon, 20 Oct 2008 09:19:56 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0810171435230.3006@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, corentincj@iksaif.net

Len,

I really appreciate the quick reply and helpful advice.

The reason why I chose that particular file to work on was two fold:
First, the ACPI team seems to be very active and helpful as a project.
 Second, that file was by far the worst in a checkpatch compliance and
could benefit the most from a little love.

Thanks again for your time, and I will follow your advice going forward.

 Thanks,
  ~ Mike


On Fri, Oct 17, 2008 at 3:52 PM, Len Brown <lenb@kernel.org> wrote:
>
>> This patch fixes 100 errors and 8 warnings found by checkpatch against
>> the asus_acpi.c file.
>>
>> It should apply cleanly to 2.6.27 and should not affect any code functionality.
>
> Hi Mike,
> Welcome!
>
> I've applied your patch to the acpi-test tree.
>
> A couple of things to note for your next patch...
>
> This particular driver has a sub-maintainer, Corentin Chary,
> as indicated in MAINTAINERS.  Chary will probably either Ack or Nak
> this patch in response to this note, but ideally you'd have sent
> the patch to Chary in the first round.
>
> Note that this particular driver is suffering bit rot
> b/c the plan is to eventually delete it in favor of
> drivers/misc/asus-laptop.c.  But I agree that as long
> as it is still in the tree, it should undergo basic
> maintenace, even if it never gets any new features.
>
> Also, best to avoid sending attachments if you can, because people
> read comment and reply to plain text, and often don't open attachments.
> From a patch application point of view, I can handle either, but
> prefer plain text because I'm also a reviwer...
>
> ref: Documentation/SubmittingPatches
>
> thanks!
> -Len
>
>
>
>
