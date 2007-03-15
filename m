From: Len Brown <lenb@kernel.org>
Subject: CONFIG_IBM_BAY
Date: Thu, 15 Mar 2007 02:06:05 -0400
Message-ID: <200703150206.05811.lenb@kernel.org>
References: <11736588493609-git-send-email-hmh@hmh.eng.br> <20070315031015.GA6292@khazad-dum.debian.net> <20070315031251.GB6292@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45244 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422813AbXCOGOk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 02:14:40 -0400
In-Reply-To: <20070315031251.GB6292@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net


> +config ACPI_IBM_BAY

Should this depend on ACPI_BAY=n?

> +	bool "Legacy Removable Bay Support"
> +	depends on ACPI_IBM
> +	default y
> +	---help---
> +	  Allows the ibm_acpi driver to handle removable bays.  It will allow
> +	  disabling the device in the bay, and also generate notifications when
> +	  the bay lever is ejected or inserted.
> +
> +	  If you are not sure, say Y here.
>
