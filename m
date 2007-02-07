From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/2] ACPI: ibm-acpi: add Ultrabay support for the T60p ThinkPad
Date: Wed, 7 Feb 2007 12:19:47 -0200
Message-ID: <20070207141947.GA21088@khazad-dum.debian.net>
References: <11707964241851-git-send-email-hmh@hmh.eng.br> <11707964243869-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:47710 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161327AbXBGOT6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 09:19:58 -0500
Content-Disposition: inline
In-Reply-To: <11707964243869-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>

On Tue, 06 Feb 2007, Henrique de Moraes Holschuh wrote:
>  IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
>  	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
> -	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */ 
> +	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60, SATA mode? */
> +	   "\\_SB.PCI0.IDE0.PRIM.MSTR", /* T60p, IDE mode? */
>  	   "\\_SB.PCI0.IDE0.SCND.MSTR",	/* all others */
>      );				/* A21e, R30, R31 */

Unfortunately, a bad design bug makes earlier entries in this list that
happen to exist shadow any later entries, which is completely unaceptable
behaviour for the bay support as earlier entries *will* exist in some
models, no matter how you order the list.

Len, if you have not pulled this one yet, please hold the pull request.  I
will not revert the patch, but rather work on a proper fix to ibm-acpi's
bay_init().

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
