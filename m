From: Stefan =?iso-8859-15?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: TM632 and S3. Network after wakeup. (kernel 2.6.10-rc3-mm1)
Date: Thu, 16 Dec 2004 21:30:27 +0100
Message-ID: <200412162130.27395.stefandoesinger@gmx.at>
References: <20041216091137.GB5605@alfa.intrak.sk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041216091137.GB5605-DNNX9asgOEN1axz1+gqgUg@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Michal Zimen <zimen-gugY4efDeRhaa/9Udqfwiw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>    Resolver did not work, i guess.
>
>    When i try to ping to another site: Uknown host.
>
>    But when i try to ping with IP address, it is all right.
Looks like you lost your network configuration. This is not really a bug, as 
you might have moved your computer somewhere else while it was suspended.

Try to restart your network, e.g. /etc/init.d/network restart, depending on 
your disto. The ifplugd daemon could take care of this for you. If you move 
between different WLANs you may want to use waproamd too.

Cheers,
Stefan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
