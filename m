From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: suspend kills serial wacom tablet
Date: Mon, 16 Apr 2007 17:25:15 -0400
Message-ID: <d120d5000704161425o2b493af6r673c8ea3d21ba91@mail.gmail.com>
References: <pan.2007.02.20.13.52.07.111117@metm.org>
	 <d120d5000704131420n65dd47d1r97442785d8617977@mail.gmail.com>
	 <4623D585.5010005@metm.org> <200704161510.18246.bjorn.helgaas@hp.com>
	 <d120d5000704161418w7603e760wb34b90d8e3974537@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:39846 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030979AbXDPVZQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Apr 2007 17:25:16 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1641020wra
        for <linux-acpi@vger.kernel.org>; Mon, 16 Apr 2007 14:25:16 -0700 (PDT)
In-Reply-To: <d120d5000704161418w7603e760wb34b90d8e3974537@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: marco <marco@metm.org>, linux-acpi@vger.kernel.org

On 4/16/07, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 4/16/07, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>
> >  It seems a bit
> > strange that the device is associated differently after resume, but
> > I don't know enough about input drivers to know whether that's by
> > design or not.
> >
>
> It should not change input devices, I would like to see output of boot
> and suspend/resume cycle with "i8042.debug log_buf_len=131072" kernel
> boot options.
>

Btw, I am really interested in that log from a recent kernel. 2.6.20
or 2.6.21-rc7.

-- 
Dmitry
