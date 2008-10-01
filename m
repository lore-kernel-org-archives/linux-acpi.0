From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: Problems evaluating WMI method
Date: Wed, 1 Oct 2008 18:55:29 +0100
Message-ID: <200810011855.30154.carlos@strangeworlds.co.uk>
References: <200809302356.09618.duartejcsilva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:47783 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbYJARzk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2008 13:55:40 -0400
In-Reply-To: <200809302356.09618.duartejcsilva@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Duarte Silva <duartejcsilva@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 30 September 2008 23:56:09 Duarte Silva wrote:
> wmi_evaluate_method("C3A72B38-D3EF-42D3-8CBB-D5A57049F66D", 1, 1, &in,
> &out);
>
> printk( KERN_INFO "QUERY %i\n", (u32)out.length);
>
> kfree(out.pointer);
>
> I get a output with a lenght of 24 and when I convert it to a acpi_object I
> get type integer. Result in dmesg
>
> QUERY 24

Ok, but what's the actual result?

e.g.

acpi_object *obj;

wmi_evaluate_method(guid, 1, 1, &in, &out);

obj = (union acpi_object *) out.pointer;

printk(KERN_INFO "RESULT %i\n", obj->value);

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
