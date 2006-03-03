From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: Possible mem leak in drivers handling multiple HIDs with single driver->ops.add
Date: Fri, 3 Mar 2006 12:20:54 -0500
Message-ID: <756b48450603030920p5fc98fc3yd7e2f40ce9a963c2@mail.gmail.com>
References: <756b48450602180252h666256fo1cb9a2bf78b9deea@mail.gmail.com>
	 <200602211033.31720.bjorn.helgaas@hp.com>
	 <756b48450603022321t66ae776dj41078b729d319ee0@mail.gmail.com>
	 <200603030906.13851.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.200]:5568 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751019AbWCCRUz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Mar 2006 12:20:55 -0500
Received: by wproxy.gmail.com with SMTP id 36so945202wra
        for <linux-acpi@vger.kernel.org>; Fri, 03 Mar 2006 09:20:54 -0800 (PST)
In-Reply-To: <200603030906.13851.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

On 3/3/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> Yes.  But you have two devices, and acpi_button_add() will get called
> once for each of them, which is exactly what we want.  Your original
> question was about this line in acpi_button_add():
>
> 311         button = kmalloc(sizeof(struct acpi_button), GFP_KERNEL);
>
> This kmalloc will happen for every button device, but the pointer is
> attached to the acpi_device:
>
>         acpi_driver_data(device) = button;
>
> and the corresponding kfree is in acpi_button_remove().

You are right. I see acpi_button_add_fs() also handles the multiple
call case correctly. Thanks for helping explain this.

jayakumar
