From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: Propose WMI patch
Date: Tue, 30 Sep 2008 12:16:10 +0100
Message-ID: <200809301216.11055.carlos@strangeworlds.co.uk>
References: <200809301206.35983.duartejcsilva@gmail.com> <200809301213.59150.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:43567 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbYI3LQO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Sep 2008 07:16:14 -0400
In-Reply-To: <200809301213.59150.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Duarte Silva <duartejcsilva@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 30 September 2008 12:13:58 Carlos Corbacho wrote:
> On Tuesday 30 September 2008 12:06:35 Duarte Silva wrote:
> > I wanted to propose a ACPI-WMI API change. Instead of having,
> > wmi_has_guid returning a boolean, why not returning a acpi_status. It
> > would allow extented error handling, and it would look more ACPI style :)
>
> NAK.
>
> We're not interested in ACPI error codes here, since we're never going to
> do anything with them.
>
> We only care if the DSDT exists or not with this method - it's just a means
> of detection for other drivers.

s/DSDT/GUID/

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
