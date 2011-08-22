From: "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: 'flags' in rsparser.c change from 'register disabled resources'
	patch
Date: Mon, 22 Aug 2011 01:59:02 +0100
Message-ID: <20110822005902.GA30602@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Witold.Szczeponik@gmx.net
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Witold,
  'sparse' is giving me the following set of warnings in the latest
kernel:

  CHECK   drivers/pnp/pnpacpi/rsparser.c
drivers/pnp/pnpacpi/rsparser.c:515:26: warning: cast truncates bits from constant value (10000000 becomes 0)
drivers/pnp/pnpacpi/rsparser.c:533:26: warning: cast truncates bits from constant value (10000000 becomes 0)
drivers/pnp/pnpacpi/rsparser.c:553:26: warning: cast truncates bits from constant value (10000000 becomes 0)
drivers/pnp/pnpacpi/rsparser.c:578:26: warning: cast truncates bits from constant value (10000000 becomes 0)
drivers/pnp/pnpacpi/rsparser.c:593:26: warning: cast truncates bits from constant value (10000000 becomes 0)
drivers/pnp/pnpacpi/rsparser.c:606:26: warning: cast truncates bits from constant value (10000000 becomes 0)
drivers/pnp/pnpacpi/rsparser.c:621:26: warning: cast truncates bits from constant value (10000000 becomes 0)
drivers/pnp/pnpacpi/rsparser.c:636:26: warning: cast truncates bits from constant value (10000000 becomes 0)
drivers/pnp/pnpacpi/rsparser.c:660:26: warning: cast truncates bits from constant value (10000000 becomes 0)
drivers/pnp/pnpacpi/rsparser.c:682:26: warning: cast truncates bits from constant value (10000000 becomes 0)

these all seem to come from the 'flags' variables you added
as part of patch 29df8d8f being char's and IORESOURCE_DISABLED 
being 0x10000000 so lines like:

+       unsigned char flags = 0;

+               flags |= IORESOURCE_DISABLED;

shouldn't work.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
