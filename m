From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Smart Battery System driver
Date: Fri, 14 Jan 2005 14:23:24 -0500
Message-ID: <41E81C2C.8010809@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all --

Recently, Bruno Ducrot posted a driver that allows access to smart
batteries, through the /dev/i2c interface. This came at just the right
time for me, since I'd recently purchased an Acer TravelMate 4502, and
had no way to monitor the status of the smart battery.

However, this driver is primarily to allow access to the SMBus inside
the embedded controller that communicates with the Smart Battery System
(SBS); other tools are required to read the battery status. Bruno
provided a userspace tool, but there is still a requirement for some
form of /proc/acpi interface that current battery-monitoring tools can read.

Accordingly, I've written a first shot at an SBS ACPI driver. This
driver, which can be downloaded from

http://shayol.bartol.udel.edu/~rhdt/download/acpi_sbs-20040114.tar.gz

...provides access to the SBS via a new /proc/acpi/sbs interface, and
also provides a "legacy" /proc/acpi/battery interface that current
battery-monitoring tools can access. This driver depends on Bruno's 
i2c-acpi-ec driver, which I have included with my source code since a 
couple of bug fixes were necessary.

Instructions for compilation and installation, plus some anticipated
FAQs, can all be found in the accompanying README file. This is my first
ever shot at kernel programming (and in fact my first real program in
C!), so please expect there to be a number of goofs; but it seems to
work OK on my system (2.6.10-gentoo-r4, with battery monitoring using
wmacpi-1.99). Let me know what you find!

On a final note, DON'T use the SBS driver if you have the ACPI battery
driver enabled in the kernel (either built-in, or as a module) -- the
two will clash over their use of /proc/acpi/battery, and things will get
Ugly(tm).

cheers,

Rich Townsend



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
