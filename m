From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] ACPI: add "Fujitsu laptop extras" module
Date: Fri, 24 Aug 2007 12:45:21 +0930 (CST)
Message-ID: <200708240315.l7O3FMCI030158@turbo.physics.adelaide.edu.au>
References: <200708232311.07335.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:45706 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752677AbXHXDPn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Aug 2007 23:15:43 -0400
In-Reply-To: <200708232311.07335.lenb@kernel.org> from "Len Brown" at Aug 23, 2007 11:11:07 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org

> Oh, i forgot to mention also...
> There should be no new files created under /proc/acpi
> for platform specific drivers.

Sure.  In the case of the backlight control (which is the thing I most care
about) this will be taken care of by virue of utilising the backlight class
as per Matthew's email.  If it did prove useful to export the mouse pointer
control for example (which at this stage is uncertain) what would be the
most appropriate location for the associated virtual files - something under
/sys?

Regards
  jonathan
