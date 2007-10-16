From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: Brightness buttons broken on Toshiba Satellite Proc A100 in kernel
 2.6.23 (Fedora8)
Date: Tue, 16 Oct 2007 10:30:50 -0400
Message-ID: <4714CB1A.7010300@redhat.com>
References: <loom.20071016T122903-517@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:35058 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758354AbXJPOax (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Oct 2007 10:30:53 -0400
In-Reply-To: <loom.20071016T122903-517@post.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Danny Baumann <dannybaumann@web.de>
Cc: linux-acpi@vger.kernel.org

On 10/16/2007 08:49 AM, Danny Baumann wrote:
> Hi,
> 
> after upgrading to Fedora 8 which brought kernel 2.6.23 with it I can no longer
> use the brightness buttons (Fn+F6/F7) on my above mentioned laptop. Pressing
> them generates F6 and F7 key events instead of ACPI events. This used to work
> fine in Fedora 7's 2.6.22.9 kernel.
> 
> Is there anything I can do to debug this? Writing a value to
> /proc/acpi/video/VGA/LCD/brightness still works fine, so it's just a matter of
> the key mapping.
> I would try to debug this myself, if I just knew where to look at; so any
> pointers in this direction would be appreciated, too.
> 

Did you look here? I think all you need is keyboard quirks for those keys...

http://people.freedesktop.org/~hughsient/quirk/

