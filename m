From: Josh Friesen <techjosh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ACPI wakeup device detection
Date: Wed, 19 Jan 2005 01:36:01 -0800
Message-ID: <3d3ce7e1050119013673a22894@mail.gmail.com>
Reply-To: techjosh-7/tV2uqVLJ6cqzYg7KEe8g@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I'd like to know if there is any way to determine what device woke up
my computer.  I'm creating a media pc (mythtv) and if the pc is woken
up by the ACPI timer then it doesn't need to start the GUI, but if it
was woken up by the power button, keyboard, the USB remote it needs to
start the GUI.  If the ethernet connection received a WOL packet then
I might want to start apache and/or samba.

I know that the ACPI specification allows the OS to determine which
device woke it up, but is that information currently extracted and, if
so, where can it be viewed?


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
