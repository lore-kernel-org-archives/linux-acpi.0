From: Duarte Silva <duartejcsilva@gmail.com>
Subject: Re: Problems evaluating WMI method
Date: Wed, 1 Oct 2008 19:22:17 +0100
Message-ID: <200810011922.17152.duartejcsilva@gmail.com>
References: <200809302356.09618.duartejcsilva@gmail.com> <200810011855.30154.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:34547 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbYJASYm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2008 14:24:42 -0400
Received: by ug-out-1314.google.com with SMTP id k3so869871ugf.37
        for <linux-acpi@vger.kernel.org>; Wed, 01 Oct 2008 11:24:40 -0700 (PDT)
In-Reply-To: <200810011855.30154.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Wednesday 01 October 2008 18:55:29 Carlos Corbacho wrote:
> On Tuesday 30 September 2008 23:56:09 Duarte Silva wrote:
> > wmi_evaluate_method("C3A72B38-D3EF-42D3-8CBB-D5A57049F66D", 1, 1, &in,
> > &out);
> >
> > printk( KERN_INFO "QUERY %i\n", (u32)out.length);
> >
> > kfree(out.pointer);
> >
> > I get a output with a lenght of 24 and when I convert it to a acpi_object
> > I get type integer. Result in dmesg
> >
> > QUERY 24
>
> Ok, but what's the actual result?
>
> e.g.
>
> acpi_object *obj;
>
> wmi_evaluate_method(guid, 1, 1, &in, &out);
>
> obj = (union acpi_object *) out.pointer;
>
> printk(KERN_INFO "RESULT %i\n", obj->value);
>
> -Carlos

It's of type integer and the result is allways one. But it is possible, Iam in 
a 64 bits platform, so three ints are 24 bytes (8 * 3)
But the strange part is that the result is allways one, when it should be 
0x0300.
