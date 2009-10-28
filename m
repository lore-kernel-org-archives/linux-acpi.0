From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 1/3] Add a generic API for _OSC
Date: Wed, 28 Oct 2009 10:19:30 +0800
Message-ID: <20091028021930.GA31320@sli10-desk.sh.intel.com>
References: <20091027063637.GA22237@sli10-desk.sh.intel.com> <4AE7174D.8090007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48718 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757128AbZJ1CT1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Oct 2009 22:19:27 -0400
Content-Disposition: inline
In-Reply-To: <4AE7174D.8090007@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Tue, Oct 27, 2009 at 11:52:45PM +0800, Alexey Starikovskiy wrote:
> Hi Shaohua,
> 
> Could you also make it take a spec string as argument, not a prepared
> byte buffer?
Hi,
did you mean take the uuid string as an argument of the API? We can
add a function to convert a uuid string to binary, but I didn't see
any benefit to take the string as argument.

Thanks,
Shaohua
