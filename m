From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH]acpi c-states: Fix ACPI C3 is wrongly mapped to C2
Date: Sat, 12 Dec 2009 15:27:27 +0100
Message-ID: <20091212142727.GA6867@comet.dominikbrodowski.net>
References: <20091212181442.GA22832@youquan-linux.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:44911 "HELO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S933838AbZLMBlF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Dec 2009 20:41:05 -0500
Content-Disposition: inline
In-Reply-To: <20091212181442.GA22832@youquan-linux.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Youquan,Song" <youquan.song@linux.intel.com>
Cc: lenb@kernel.org, venkatesh.pallipadi@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, youquan.song@intel.com, linux-acpi@vger.kernel.org

On Sat, Dec 12, 2009 at 01:14:42PM -0500, Youquan,Song wrote:
> On Nehalem-EX, CPU C3 is mapped to ACPI C3, but C-states information in /proc
>  and /sys are conflicting with ACPI C2 mapping and confused user.

Well, isn't the "type" only losely related to the C-state number anyway, if
you have more than 3 states?

Best,
	Dominik
