From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [BUGFIX] ACPI, APEI, EINJ Param support is disabled by default
Date: Thu, 21 Jul 2011 06:50:27 +0200
Message-ID: <20110721045027.GM8006@one.firstfloor.org>
References: <1311149369-20624-1-git-send-email-ying.huang@intel.com> <20110721024204.GJ8006@one.firstfloor.org> <4E2794D5.1030104@intel.com> <20110721041610.GL8006@one.firstfloor.org> <4E27AA99.4000102@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:55961 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab1GUEu2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jul 2011 00:50:28 -0400
Content-Disposition: inline
In-Reply-To: <4E27AA99.4000102@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>

> To avoid confuse user, the param1/param2 files are created only if
> param_extension=y is specified.  So making modprams changeable in run
> time may make situation a little complex.

Good point. Ok then not.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
