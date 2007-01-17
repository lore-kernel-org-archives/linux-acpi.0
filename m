From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: HP Compaq nc6320 - Booting on battery power causes softlock
Date: Wed, 17 Jan 2007 15:52:32 +0000
Message-ID: <1169049152.5743.0.camel@localhost>
References: <1169002596.29755.5.camel@localhost>
	 <3877989d0701161904u6ef2b931t99b79d92dd974f2a@mail.gmail.com>
	 <200701162215.34627.lenb@kernel.org>  <1169043719.6273.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:60402 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbXAQPww (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jan 2007 10:52:52 -0500
In-Reply-To: <1169043719.6273.8.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Luming Yu <luming.yu@gmail.com>, linux-acpi@vger.kernel.org

On Wed, 2007-01-17 at 14:21 +0000, Peter Clifton wrote:

> Ok, I've tested acpi=off and apm=off with the stock Ubuntu kernel. It
> didn't softlock with either, but I'll try to use one of the two when
> booting now to ensure it is consistent.

Ok, having tried some more, apm=off can still give a softlock. Will keep
trying with acpi=off.

Peter C.


