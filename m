From: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Subject: Re: How to control Thermal zone
Date: Tue, 14 Dec 2004 13:51:35 +0100
Message-ID: <41BEE1D7.9060007@renninger.de>
References: <41B8FC12.5090602@yahoo.com.br> <20041210142425.GB3654@openzaurus.ucw.cz> <41BDAEB5.3040308@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41BDAEB5.3040308-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Francisco Figueiredo Jr." <fxjrlists-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Francisco Figueiredo Jr. wrote:
> Pavel Machek wrote:
> | Hi!
> |>I mean, The fan is being correctly turned on and off but only after
> |>getting some threshold. When the laptop is turned on and my thermal
> |>zone
> |>temp is 35C fan is kept on when it could be turned off.
> |>
> |>Any tips?
> |
> |
> | You can just echo 1:2:3 > trip_points...
> |                 Pavel
> 
> 
> What do this do?
> I don't know trip_points and what their parameters mean. Could you
> explain it, please?

echo "critical:hot:passive:active1:active2:activeX" > trip_points
e.g.:
echo "90:80:45:40:38" > trip_points

means:
90 degree -> critical -> machine should shutdown (e.g. by acpid)
80 degree -> hot      -> gets dangerous
45 degree -> passive  -> Set CPU frequency, throttling (CPU performance)
                          down in order to cool system
40 degree -> active1  -> turn on active cooling device 1
                          This normally is a fan (or an intensity of a
                          fan)
38 degree -> active2  ...

To modifiy the trip points they have to be exported by your BIOS, 
otherwise those values are ignored ...

echo 5 > polling_frequency is a good idea as well.

However the thermal module still has some bugs (e.g. once you entered 
passive cooling it always will be displayed in state (but your machine 
should be fast again))
To track down what's going on compile with CONFIG_ACPI_DEBUG=y
and:
echo 0xFFFF0000 >/proc/acpi/debug_layer
echo 0x00000FFF >/proc/acpi/debug_level
and watch your syslogger output...

         Thomas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
