From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Smart Battery System driver
Date: Mon, 17 Jan 2005 12:33:59 +0100
Message-ID: <20050117113359.GR19199@poupinou.org>
References: <41E81C2C.8010809@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41E81C2C.8010809-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 14, 2005 at 02:23:24PM -0500, Rich Townsend wrote:
> Hi all --
> 
> Recently, Bruno Ducrot posted a driver that allows access to smart
> batteries, through the /dev/i2c interface. This came at just the right
> time for me, since I'd recently purchased an Acer TravelMate 4502, and
> had no way to monitor the status of the smart battery.
> 
> However, this driver is primarily to allow access to the SMBus inside
> the embedded controller that communicates with the Smart Battery System
> (SBS); other tools are required to read the battery status. Bruno
> provided a userspace tool, but there is still a requirement for some
> form of /proc/acpi interface that current battery-monitoring tools can read.
> 
> Accordingly, I've written a first shot at an SBS ACPI driver. This
> driver, which can be downloaded from
> 
> http://shayol.bartol.udel.edu/~rhdt/download/acpi_sbs-20040114.tar.gz
> 

That's fine!  Many thanks.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
